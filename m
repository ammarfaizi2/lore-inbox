Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262716AbRFCBXF>; Sat, 2 Jun 2001 21:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262719AbRFCBWz>; Sat, 2 Jun 2001 21:22:55 -0400
Received: from DOMINIA.MIT.EDU ([18.208.0.43]:3081 "EHLO dominia.org")
	by vger.kernel.org with ESMTP id <S262716AbRFCBWr>;
	Sat, 2 Jun 2001 21:22:47 -0400
Date: Sat, 2 Jun 2001 21:22:46 -0400 (EDT)
From: "Hayden A. James" <hjames@dominia.org>
To: <linux-kernel@vger.kernel.org>
Subject: Re: USB mouse problem
Message-ID: <Pine.LNX.4.33.0106022120490.32178-100000@dominia.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a followup to my last e-mail, here is some information about my
mouse/usb setup from dmesg.

usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.251 $ time 20:53:29 Apr  8 2001
usb-uhci.c: High bandwidth mode enabled
PCI: Found IRQ 4 for device 00:04.2
PCI: The same IRQ used for device 00:09.0
PCI: The same IRQ used for device 00:09.1
PCI: The same IRQ used for device 00:0d.0
usb-uhci.c: USB UHCI at I/O 0xb400, IRQ 4
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: USB new device connect on bus1/2, assigned device number 2
usb.c: USB device 2 (vend/prod 0x46d/0xc00b) is not claimed by any active
driver.
usb.c: registered new driver hid
input0: USB HID v1.10 Mouse [Logitech USB Mouse] on usb1:2.0
mouse0: PS/2 mouse device for input0
mice: PS/2 mouse device common for all mice

I am using /dev/mouse which is a symlink to /dev/input/mice.
crw-------    1 root     root      13,  63 Mar 23 23:37 /dev/input/mice


Hayden A. James

