Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284171AbRLRQO4>; Tue, 18 Dec 2001 11:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284176AbRLRQOs>; Tue, 18 Dec 2001 11:14:48 -0500
Received: from noodles.codemonkey.org.uk ([62.49.180.5]:64919 "EHLO
	noodles.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id <S284171AbRLRQOm>; Tue, 18 Dec 2001 11:14:42 -0500
Date: Tue, 18 Dec 2001 16:16:25 +0000
From: Dave Jones <davej@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.1-dj3
Message-ID: <20011218161625.A16889@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up some merge errors, scoop up another bunch of pending fixes
expected to hit Linus' tree soon, and drop some problem bits.

Patch is available from:
http://www.codemonkey.org.uk/patches/2.5/patch-2.5.1-dj3.diff.bz2

On with the changelog..

Some of these fixes still haven't found their way back to Marcelo yet
but should show up in 2.4.17-rc2 / 2.4.18pre1 with any luck.

2.5.1-dj3
o   Drop Manfreds multithread coredump changes		(Me)
    | They caused ltp waitpid05 regression on 2.5
    | (Same patch is fine for 2.4)
o   Intermezzo compile fix.				(Chris Wright)
o   Fix ymfpci & hisax merge errors.			(Me)
o   Drop ad1848 sound driver changes in favour of 2.5	(Me)
o   Make hpfs work again.				(Al Viro)
o   Alpha Jensen compile fixes.				(Ronald Lembcke)
o   Make NCR5380 compile non modularly.			(Erik Andersen)


2.5.1-dj2
o   bio fixes for qlogicfas.			(brett@bad-sports.com)
o   Correct x86 CPU helptext.			(Me)
o   Fix serial.c __ISAPNP__ usage.		(Andrey Panin)
o   Use better ide-floppy fixes.		(Jens Axboe)
o   Make NFS 'fsx' proof.			(Trond Mykelbust)
    | 2 races & 4 bugs, hopefully this is all.
o   devfs update				(Richard Gooch)
o   Backout early CPU init, needs more work.	(Me)
    | This should fix several strange reports.
o   drop new POSIX kill semantics for now	(Me)

2.5.1-dj1
o   Resync with 2.5.1
    | drop reiserfs changes. 2.4's look to be more complete.
o   Fix potential sysvfs oops.				(Christoph Hellwig)
o   Loopback driver deadlock fix.			(Andrea Arcangeli)
o   __devexit cleanups in drivers/net/			(Daniel Chen,
    synclink, wdt_pci & via82cxxx_audio 		 John Tapsell)
o   Configure.help updates				(Eric S. Raymond)
o   Make reiserfs compile again.				(Me)
o   bio changes for ide floppy					(Me)
    | handle with care, compiles, but is unfinished.
o   Make x86 identify_cpu() happen earlier			(Me)
    | PPro errata workaround & APIC setup got a little
    | cleaner as a result.
o   Blink keyboard LEDs on panic				(From 2.4.13-ac)
o   Change current->state frobbing to set_current_state()	(From 2.4.13-ac)
o   Add MODULE_LICENSE tags for acpi,md.c,fmvj18x,		(From 2.4.13-ac)
    atyfb & fbmem.

2.5.1pre11-dj2
o   Merge with 2.4.17rc1
o   Activate out of order stores on IDT Winchips.		(From 2.4.13-ac)
o   ICH2 APIC support						(From 2.4.13-ac)
o   Activate Simple boot flag support				(From 2.4.13-ac)
    | was merged in -dj1, but not mentioned.
o   Remove matroxfb PLL debugging message.			(Me)

2.5.1pre11-dj1
o   Merge with 2.4.17pre8
    Drop devfs changes. (Newer version in 2.5)
o   Make ncr53c8xx bio aware.					(Me)


-- 
| Dave Jones.                    http://www.codemonkey.org.uk
| SuSE Labs .
