Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267681AbRGUPnT>; Sat, 21 Jul 2001 11:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267682AbRGUPnJ>; Sat, 21 Jul 2001 11:43:09 -0400
Received: from jdi.jdimedia.nl ([212.204.192.51]:63953 "EHLO jdi.jdimedia.nl")
	by vger.kernel.org with ESMTP id <S267681AbRGUPmy>;
	Sat, 21 Jul 2001 11:42:54 -0400
Date: Sat, 21 Jul 2001 17:42:36 +0200 (CEST)
From: Igmar Palsenberg <i.palsenberg@jdimedia.nl>
X-X-Sender: <igmar@jdi.jdimedia.nl>
To: <linux-kernel@vger.kernel.org>
Subject: [2.4.6] USB thinks I've got 2 keyboards
Message-ID: <Pine.LNX.4.33.0107211739340.28026-100000@jdi.jdimedia.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


A HP pavilion with a USB keyboard and mouse :

Kernel : 2.4.6

usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Found IRQ 9 for device 00:1f.2
PCI: Setting latency timer of device 00:1f.2 to 64
uhci.c: USB UHCI at I/O 0xa400, IRQ 9
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
uhci.c: :USB Universal Host Controller Interface driver
usb.c: registered new driver hid
hid.c: v1.16:USB HID support drivers

hub.c: USB new device connect on bus1/1, assigned device number 2
hub.c: USB hub found
hub.c: 3 ports detected
hub.c: USB new device connect on bus1/2, assigned device number 3
hub.c: USB hub found
hub.c: 4 ports detected
hub.c: USB new device connect on bus1/1/1, assigned device number 4
event0: Event device for input0
keybdev.c: Adding keyboard: input0
input0: USB HID v1.00 Keyboard [HP Multimedia Keyboard Hub] on usb1:4.0
event1: Event device for input1
keybdev.c: Adding keyboard: input1
input1: USB HID v1.00 Device [HP Multimedia Keyboard Hub] on usb1:4.1
hub.c: USB new device connect on bus1/2/1, assigned device number 5
event2: Event device for input2
mouse0: PS/2 mouse device for input2
input2: USB HID v1.00 Mouse [Logitech] on usb1:5.0
keyboard: Timeout - AT keyboard not present?

input0 and input1 are the same device actually.


	Igmar


-- 

Igmar Palsenberg
JDI Media Solutions

Boulevard Heuvelink 102
6828 KT Arnhem
The Netherlands

mailto: i.palsenberg@jdimedia.nl
PGP/GPG key : http://www.jdimedia.nl/formulier/pgp/igmar

