Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132561AbRAJLtm>; Wed, 10 Jan 2001 06:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135270AbRAJLtc>; Wed, 10 Jan 2001 06:49:32 -0500
Received: from styx.suse.cz ([195.70.145.226]:61943 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S135351AbRAJLtP>;
	Wed, 10 Jan 2001 06:49:15 -0500
Date: Wed, 10 Jan 2001 12:49:11 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Benson Chow <blc@q.dyndns.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB Keyboards for x86/uhci in 2.4- kernels?
Message-ID: <20010110124911.A2134@suse.cz>
In-Reply-To: <Pine.LNX.4.31.0101091640470.21522-100000@q.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.31.0101091640470.21522-100000@q.dyndns.org>; from blc@q.dyndns.org on Tue, Jan 09, 2001 at 11:55:14PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2001 at 11:55:14PM -0700, Benson Chow wrote:
> Anyone tried using these beasts on a x86?
> 
> Anyway, what's happening:   In BIOS my USB keyboard works really poorly -
> it almost seems scancodes get dropped left and right.  Ok, so I don't mind
> too much, i'm sure BIOS has a very limited driver.  After booting
> Microsoft's offerring, it would work fine after it installs its driver.
> I also tried this same keyboard on a HPUX Visualize C3600 workstation and
> it also works nicely.
> 
> However linux would never fix  this "scancode drop" syndrome even after
> loading the hid or usbkbd driver.  Both my Via uhci USB motherboard and
> PIIX3 USB motherboard exhibit this usb keyboard strangeness
> with the hid or usbkbd driver is installed.  I think the PIIX3
> motherboard's bios doesnt handle USB properly so it doesn't even work in
> BIOS setup.  Any idea what's going on?  Is there some other driver or
> utility I need to install/run to get it working?  Maybe just my bad bios?
> 
> BTW: my USB Mouse, and USB Printer seem to work nicely in 2.4.0-release.
> 
> USB KBD: NMB USB 104-key PC-Style
> USB Mouse: Microsoft Intellimouse w/Intellieye 1.0, Logitech Optical Wheel
> USB Printer: HP Deskjet 880C
> USB Hub: Belkin 4-port
> Intel 82437SB(?) PIIX3 and Via 82C686(?) USB controller
> 
> Working: Stock HPUX10.2 HP Visualize C3600 PARISC2 Workstation
> Working: Microsoft Windows 98 First Edition on the Via.

What modules are loaded?
What's in /proc/bus/usb/devices?
What's in dmesg?

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
