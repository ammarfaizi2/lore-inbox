Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263510AbUAIR2H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 12:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263561AbUAIR2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 12:28:07 -0500
Received: from out003pub.verizon.net ([206.46.170.103]:32767 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S263510AbUAIR1s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 12:27:48 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None that appears to be detectable by casual observers
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: usb probs 2.6.1-mm1
Date: Fri, 9 Jan 2004 12:27:45 -0500
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401091227.45101.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [151.205.61.108] at Fri, 9 Jan 2004 11:27:45 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greets;

I haven't tried 2.6.1 plain, but I've lost my scanner and a few other 
things on the usb bus with 2.6.1-mm1.  They've not been working for 
several days now.  With all modules builtin, dmesg reports:

Linux version 2.6.1-mm1 (root@coyote.coyote.den) (gcc version 3.2 
20020903 (Red Hat Linux 8.0 3.2-7)) #1 Fri Jan 9 11:46:45 EST 2004
[...]
Linux video capture interface: v1.00
bttv: driver version 0.9.12 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
bttv0: Bt878 (rev 17) at 0000:00:09.0, irq: 5, latency: 32, mmio: 
0xe3004000
bttv0: detected: Hauppauge WinTV [card=10], PCI subsystem ID is 
0070:13eb
bttv0: using: Hauppauge (bt878) [card=10,autodetected]
bttv0: Hauppauge/Voodoo msp34xx: reset line init [5]
bttv0: Hauppauge eeprom: model=44811, tuner=Temic 4039FR5 (21), 
radio=yes
bttv0: using tuner=21
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: registered device radio0
bttv0: PLL: 28636363 => 35468950 .. ok
tvaudio: TV audio decoder + audio/video mux driver
tvaudio: known chips: 
tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6420,tda8425,pic16c54 
(PV951),ta8874z
tuner: chip found @ 0xc2
tuner: type set to 21 (Temic NTSC (4039 FR5))
registering 0-0061
[...]
uhci_hcd 0000:00:11.2: UHCI Host Controller
uhci_hcd 0000:00:11.2: irq 11, io base 0000dc00
uhci_hcd 0000:00:11.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
uhci_hcd 0000:00:11.3: UHCI Host Controller
uhci_hcd 0000:00:11.3: irq 11, io base 0000e000
uhci_hcd 0000:00:11.3: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:11.4: UHCI Host Controller
uhci_hcd 0000:00:11.4: irq 11, io base 0000e400
uhci_hcd 0000:00:11.4: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
drivers/usb/core/usb.c: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
drivers/usb/core/usb.c: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
drivers/usb/serial/usb-serial.c: Had to override the write_room usb 
serial operation with the generic one.
drivers/usb/serial/usb-serial.c: Had to override the chars_in_buffer 
usb serial operation with the generic one.
drivers/usb/serial/usb-serial.c: USB Serial support registered for 
PL-2303
drivers/usb/core/usb.c: registered new driver pl2303
drivers/usb/serial/pl2303.c: Prolific PL2303 USB to serial adaptor 
driver v0.10
mice: PS/2 mouse device common for all mice
input: PC Speaker
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
i2c /dev entries driver
tuner: type already set (21)
registering 0-0050
tuner: type already set (21)
registering 0-0051
tuner: type already set (21)
registering 0-0052
tuner: type already set (21)
registering 0-0053
tuner: type already set (21)
registering 0-0054
tuner: type already set (21)
registering 0-0055
tuner: type already set (21)
registering 0-0056
tuner: type already set (21)
registering 0-0057
registering 1-0050
registering 1-0051
[...]
btaudio: driver version 0.7 loaded [digital+analog]
btaudio: Bt878 (rev 17) at 00:09.1, irq: 5, latency: 32, mmio: 
0xe3005000
btaudio: using card config "default"
btaudio: registered device dsp1 [digital]
btaudio: registered device dsp2 [analog]
btaudio: registered device mixer1
Advanced Linux Sound Architecture Driver Version 1.0.1 (Tue Dec 30 
10:04:14 2003 UTC).
can't register device seq
unable to register OSS mixer device 0:0
ALSA device list:
  #0: Virtual MIDI Card 1
[...]
hub 3-0:1.0: new USB device on port 2, assigned address 2
hub 3-2:1.0: USB hub found
hub 3-2:1.0: 4 ports detected
hub 3-2:1.0: new USB device on port 1, assigned address 3
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 3 if 
0 alt 0 proto 2 vid 0x04B8 pid 0x0005
hub 3-2:1.0: new USB device on port 3, assigned address 4
drivers/usb/serial/usb-serial.c: descriptor matches
drivers/usb/serial/usb-serial.c: found interrupt in
drivers/usb/serial/usb-serial.c: found bulk out
drivers/usb/serial/usb-serial.c: found bulk in
pl2303 3-2.3:1.0: PL-2303 converter detected
drivers/usb/serial/usb-serial.c: get_free_serial 1
drivers/usb/serial/usb-serial.c: get_free_serial - minor base = 0
drivers/usb/serial/usb-serial.c: usb_serial_probe - setting up 1 port 
structures for this device
drivers/usb/serial/usb-serial.c: usb_serial_probe - registering 
ttyUSB0
usb 3-2.3: PL-2303 converter now attached to ttyUSB0 (or usb/tts/0 for 
devfs)
hub 3-2:1.0: new USB device on port 4, assigned address 5
drivers/usb/core/config.c: couldn't get all of config descriptors
usb 3-2.4: can't read configurations, error -110
hub 3-2:1.0: new USB device on port 4, assigned address 6
hub 2-0:1.0: new USB device on port 2, assigned address 2
hub 1-0:1.0: new USB device on port 1, assigned address 2
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on 
usb-0000:00:11.2-1
hub 1-0:1.0: new USB device on port 2, assigned address 3
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 3 if 
0 alt 0 proto 2 vid 0x04B8 pid 0x0005
[...]
request_module: failed /usr/local/sbin/modprobe -- block-major-8-1. 
error = 256
hdc: DMA disabled
------------------------------
Yes, there are two usb printers.  And dma to hdc did work previously, 
its my cdr/w drive.

Also, the last version of usbutils doesn't show anything because its 
looking in /proc/bus/usb but everything has now been moved to 
/sys/bus/usb.

I just got this in the messages log for unplugging, and replugging the 
scanner:
Jan  9 12:21:17 coyote kernel: usb 2-2: USB disconnect, address 2
Jan  9 12:21:17 coyote kernel: updfstab: numerical sysctl 1 23 is 
obsolete.
Jan  9 12:21:17 coyote /etc/hotplug/usb.agent: Bad USB agent 
invocation
Jan  9 12:21:43 coyote kernel: hub 2-0:1.0: new USB device on port 2, 
assigned address 3
Jan  9 12:21:43 coyote /etc/hotplug/usb.agent: Bad USB agent 
invocation
Jan  9 12:21:46 coyote /etc/hotplug/usb.agent: ... no modules for USB 
product 4b8/10f/100

The installed libusb is now yesterdays cvs.

Clues?

Do I need a fresher version of usbutils that the 9.7 I just dl'd and 
ungraded to 10 minutes ago?.

Or did I look in the wrong place, it was one of the top choices of a 
google search.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

