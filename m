Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291485AbSBABkA>; Thu, 31 Jan 2002 20:40:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291486AbSBABju>; Thu, 31 Jan 2002 20:39:50 -0500
Received: from noodles.codemonkey.org.uk ([62.49.180.5]:51344 "EHLO
	noodles.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id <S291485AbSBABjc>; Thu, 31 Jan 2002 20:39:32 -0500
Date: Fri, 1 Feb 2002 01:39:30 +0000
From: Dave Jones <davej@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.3-dj1
Message-ID: <20020201013930.A24971@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And we start all over again.. Sync against 2.5.3, and merge some
more pending items. Hopefully this fixes the reiserfs issues
that popped up in -dj7 (but mysteriously not in mainline).
please report reiserfs success/failure stories.

Patch against 2.5.3 vanilla is available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/

 -- Davej.

2.5.3-dj1
o   Merge 2.5.3final
    | Drop NCR5380 changes for now. For reasons why, read
    | http://kt.zork.net/kernel-traffic/kt20020121_151.html#4
o   MAINTAINERS updates.				(Me)
o   Move IA64 perfmon init out of init/main.c		(Me)
o   Several #include linux/malloc.h -> linux/slab.h	(Me)
o   Remove bogus duplicate dmi_scan()			(Me)
o   Remove duplicate code in bootsect.S			(Rob Landley)
o   ScanLogic USB-ATAPI adapter support.		(Leif Sawyer)
o   Shrink dqcache by priority.				(Josh MacDonald)
o   Fix up BKL removal breakage in HFS & UFS.		(Robert Love, Me)
o   Config.help updates for GUID partition support.	(Matt Domsch)
o   Updated USB driverfs support.			(Greg KH)
o   Fix modular USB build.				(Jim McDonald)
o   Handle error case in sys_swapon()			(Andrey Panin)
o   i810_audio build fix.				(Martin Bahlinger)
o   text.lock->subsection improvements.			(Keith Owens)
o   Support an extra mystery rocketport card.		(Andi Kleen)
o   zlib_inflate build fix.				(Andi Kleen)
o   Remove inclusion of sched.h for most of fs/		(Me)
    | pushes CURRENT_TIME into wait.h
    | There's still work to do here.
o   Debug trap for vfree.				(Arjan van de Ven)
o   Make xconfig find help texts again.			(Olaf Dietsche)
o   Fix nbd breakage.					(Petr Vandrovec)
o   IBM partition compile fix.				(Sergey S. Kostyliov)
o   More reiserfs fixes.				(Oleg Drokin)


2.5.2-dj7
o   Merge 2.5.3pre6
o   Remove fs.h inclusion from sched.h again.		(Christoph Hellwig)
o   Remove some segment.h inclusions that reappeared.	(Me)
o   Unmangle dl2k crc fix from -dj6			(Jim McDonald)
o   Fix tsdev compile.					(Me)
o   aty128fb & radeonfb compile fixes.			(James Simmons)
o   Updated Config.help entries for input layer.	(Vojtech Pavlik)
o   Input layer tweak for old IBM keyboards.		(Vojtech Pavlik)
o   Fix USB HID feature report output.			(Vojtech Pavlik)
o   Workaround some broken PS/2 mice.			(Vojtech Pavlik)
o   Don't filter outgoing fields to HID defined ranges.	(Vojtech Pavlik)
o   Disable address in scatterlist for sg.		(Douglas Gilbert)
o   Limit NR_IRQS in no IO-APIC case.			(Brian Gerst)
o   Sonypi driver update (C1MRX Vaio).			(Stelian Pop)
o   Remove bogus release_region in eexpress.		(Gianluca Anzolin)
o   Neofb compile fixes.				(James Simmons)
o   Reiserfs update.					(all@namesys)
o   Further reiserfs fixes.				(Oleg Drokin)
o   Fix keyboard not working with nothing in AUX port.	(Vojtech Pavlik)
o   Small devfs changes.				(Richard Gooch)
o   Rage128 Pro TF identification to aty128fb.		(James Simmons)




-- 
Dave Jones.                    http://www.codemonkey.org.uk
SuSE Labs.
