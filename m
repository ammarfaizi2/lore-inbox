Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133036AbRAWBOH>; Mon, 22 Jan 2001 20:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135604AbRAWBN6>; Mon, 22 Jan 2001 20:13:58 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:31250 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S133036AbRAWBNr>; Mon, 22 Jan 2001 20:13:47 -0500
Date: Mon, 22 Jan 2001 17:13:19 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.4.1-test10
Message-ID: <Pine.LNX.4.10.10101221711560.1309-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The ChangeLog may not be 100% complete. The physically big things are the
PPC and ACPI updates, even if most people won't notice.

		Linus

----

pre10:
 - got a few too-new R128 #defines in the Radeon merge. Fix.
 - tulip driver update from Jeff Garzik
 - more cpq and DAC elevator fixes from Jens. Looks good.
 - Petr Vandrovec: nicer ncpfs behaviour
 - Andy Grover: APCI update
 - Cort Dougan: PPC update
 - David Miller: sparc updates
 - David Miller: networking updates
 - Neil Brown: RAID5 fixes

pre9:
 - cpq array driver elevator fixes 
 - merge radeon driver from X CVS tree
 - ispnp cleanups
 - emu10k unlock on error fixes
 - hpfs doesn't allow truncate to larger

pre8:
 - Don't drop a megabyte off the old-style memory size detection
 - remember to UnlockPage() in ramfs_writepage()
 - 3c59x driver update from Andrew Morton
 - egcs-1.1.2 miscompiles depca: workaround by Andrew Morton
 - dmfe.c module init fix: Andrew Morton
 - dynamic XMM support. Andrea Arkangeli.
 - ReiserFS merge
 - USB hotplug updates/fixes
 - boots on real i386 machines
 - blk-14 from Jens Axboe
 - fix DRM R128/AGP dependency
 - fix n_tty "canon" mode SMP race
 - ISDN fixes
 - ppp UP deadlock attack fix
 - FAT fat_cache SMP race fix
 - VM balancing tuning
 - Locked SHM segment deadlock fix
 - fork() page table copy race fix

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
