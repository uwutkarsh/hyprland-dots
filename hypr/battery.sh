#!/bin/bash

# Find the first battery available
battery=$(ls /sys/class/power_supply | grep -m 1 '^BAT')

if [ -z "$battery" ]; then
  echo "Error: No battery detected!"
  exit 1
fi

while true; do
  battery_level=$(cat /sys/class/power_supply/$battery/capacity)
  battery_status=$(cat /sys/class/power_supply/$battery/status)

  if [ "$battery_status" = "Discharging" ] && [ "$battery_level" -le 25 ]; then
    notify-send --urgency=critical "Charge me Utkarsh >ᴗ<!" "Battery level is ${battery_level}%!"
  fi

  # Check every 5 minutes
  sleep 300
done
