Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261667AbULZPNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbULZPNP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 10:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261669AbULZPNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 10:13:15 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:16057 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261667AbULZPNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 10:13:08 -0500
From: kernel-stuff@comcast.net (Parag Warudkar)
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-usb-users@lists.sourceforge.net,
       vojtech@suse.cz
Subject: Re: Ho ho ho - Linux v2.6.10 [USB Issues]
Date: Sun, 26 Dec 2004 15:13:06 +0000
Message-Id: <122620041513.15494.41CED5020009670D00003C86220075115000009A9B9CD3040A029D0A05@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Nov 22 2004)
X-Authenticated-Sender: a2VybmVsLXN0dWZmQGNvbWNhc3QubmV0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The USB mouse (Kensington Pocket Pro) on my laptop (Athlon64) stopped working after I switched to 2.6.10 from FC3-2.6.9 (I get an USB HC Takeover failed message after I connect the mouse). Also my other two USB storage devices (iPod and Maxtor External drive) generate an 'read/64' error when connected but work fine.

dmesg | grep -i usb
=========================
usbcore: registered new driver usbfs
usbcore: registered new driver hub
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
USB0 USB1 USB2 PS2K PS2M MAC0
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:02.2: USB 2.0 initialized, EHCI 1.00, driver 26 Oct 2004
hub 1-0:1.0: USB hub found
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
usb 1-1: new high speed USB device using ehci_hcd and address 2
usb 1-1: device descriptor read/64, error -71
Initializing USB Mass Storage driver...
scsi0 : SCSI emulation for USB Mass Storage devices
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usb-storage: device found at 2
usb-storage: waiting for device to settle before scanning
ohci_hcd 0000:00:02.0: USB HC TakeOver failed!
usb-storage: device scan complete
ohci_hcd 0000:00:02.1: USB HC TakeOver failed!
usb 1-2: new high speed USB device using ehci_hcd and address 4
usb 1-2: device descriptor read/64, error -71
scsi1 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 4
usb-storage: waiting for device to settle before scanning
usb-storage: device scan complete



