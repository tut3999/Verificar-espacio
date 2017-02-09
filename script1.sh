#!/bin/bash
df -H | grep -vE '^Filesysrem|tmpfs|cdrom|udev' | awk '{print $5 " " $1 }' | while read text;
do
	echo $text
	usep=$(echo $text | awk '{ print $1}' | cut -d'%' -f1)
	partition=$(echo $text | awk '{print $2}')

#tengo que revisar que $usep sea un numeropara que no mande advertencia 
	echo $usep
	if [ $usep -ge 80 ]; then
		echo `sudo notify-send "Advertencia \"$partition\" esta al 90% de su uso"`
	else 
		if [ $usep -ge 60 ]; then
			echo "Tienes un 60% en la particion \"$partition\""
		fi
	fi
done
