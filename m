Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130340AbRAJGzi>; Wed, 10 Jan 2001 01:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130348AbRAJGz1>; Wed, 10 Jan 2001 01:55:27 -0500
Received: from dnvrdslgw14poolB96.dnvr.uswest.net ([63.228.85.96]:16214 "EHLO
	q.dyndns.org") by vger.kernel.org with ESMTP id <S130340AbRAJGzN>;
	Wed, 10 Jan 2001 01:55:13 -0500
Date: Tue, 9 Jan 2001 23:55:14 -0700 (MST)
From: Benson Chow <blc@q.dyndns.org>
To: <linux-kernel@vger.kernel.org>
Subject: USB Keyboards for x86/uhci in 2.4- kernels?
Message-ID: <Pine.LNX.4.31.0101091640470.21522-100000@q.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anyone tried using these beasts on a x86?

Anyway, what's happening:   In BIOS my USB keyboard works really poorly -
it almost seems scancodes get dropped left and right.  Ok, so I don't mind
too much, i'm sure BIOS has a very limited driver.  After booting
Microsoft's offerring, it would work fine after it installs its driver.
I also tried this same keyboard on a HPUX Visualize C3600 workstation and
it also works nicely.

However linux would never fix  this "scancode drop" syndrome even after
loading the hid or usbkbd driver.  Both my Via uhci USB motherboard and
PIIX3 USB motherboard exhibit this usb keyboard strangeness
with the hid or usbkbd driver is installed.  I think the PIIX3
motherboard's bios doesnt handle USB properly so it doesn't even work in
BIOS setup.  Any idea what's going on?  Is there some other driver or
utility I need to install/run to get it working?  Maybe just my bad bios?

BTW: my USB Mouse, and USB Printer seem to work nicely in 2.4.0-release.

USB KBD: NMB USB 104-key PC-Style
USB Mouse: Microsoft Intellimouse w/Intellieye 1.0, Logitech Optical Wheel
USB Printer: HP Deskjet 880C
USB Hub: Belkin 4-port
Intel 82437SB(?) PIIX3 and Via 82C686(?) USB controller

Working: Stock HPUX10.2 HP Visualize C3600 PARISC2 Workstation
Working: Microsoft Windows 98 First Edition on the Via.

Thanks!
-bc


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
