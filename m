Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286383AbRL0RhS>; Thu, 27 Dec 2001 12:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286382AbRL0Rg6>; Thu, 27 Dec 2001 12:36:58 -0500
Received: from noodles.codemonkey.org.uk ([62.49.180.5]:37317 "EHLO
	noodles.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id <S286379AbRL0Rgt>; Thu, 27 Dec 2001 12:36:49 -0500
Date: Thu, 27 Dec 2001 17:37:55 +0000
From: Dave Jones <davej@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.1-dj6
Message-ID: <20011227173755.A25445@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-ENOMORETURKEY, so here goes with more resyncing, more backlogged fixes,
and some pending experimental bits that should end up Linuswards soon.
This is a fairly big merge, so it may take another release or two to
shake out any merge errors.

Patch against 2.5.1 vanilla is available from:
http://www.codemonkey.org.uk/patches/2.5/patch-2.5.1-dj6.diff.bz2

Some of the fixes still haven't found their way back to Marcelo yet
but should show up in 2.4.18pre1 with any luck.

Enjoy,
  -- Davej.

2.5.1-dj6
o   Merge 2.5.2pre2
    | Includes updated for 2.5 SCSI debug driver.	(Douglas Gilbert)
o   Merge 2.4.18pre1
o   Missing include in sunrpc sched.c			(David S. Miller)
o   Remove incorrect devinit's from bttv & USB.		(Andrew Morton)
o   Remove redundant EISA_bus__is_a_macro macro.	(Me)
o   Split visws support to setup-visws.c		(Me)
    | Can someone with one of these beasts test this, and maybe
    | even *gulp* maintain it ?
o   pc110pad spinlock thinko				(Peter T. Breuer)
o   Fix reiserfs + highmem possible oops.		(Oleg Drokin)
o   Fix reiserfs fsx breakage.				(Oleg Drokin)
o   Make IPV6 accept timestamps in response to SYNs.	(Alexey Kuznetsov)
o   NCR5380_timer_fn needs to be static.		(Rasmus Andersen)
o   CONFIG_SERIAL_ACPI is IA64 only.			(Me)


2.5.1-dj5
o   Sync up to 2.5.2pre1
o   Merge 2.4.17final.
o   Gravis ultrasound PnP update		(Andrey Panin)


2.5.1-dj4
o   Merge with 2.4.17-rc2
    | Most was already here, more or less just fixes for
    | reiserfs & netfilter, and some VM changes.


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


-- 
Dave Jones.                    http://www.codemonkey.org.uk
SuSE Labs.
