Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287697AbSASX7l>; Sat, 19 Jan 2002 18:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287743AbSASX7c>; Sat, 19 Jan 2002 18:59:32 -0500
Received: from noodles.codemonkey.org.uk ([62.49.180.5]:25760 "EHLO
	noodles.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id <S287697AbSASX7V>; Sat, 19 Jan 2002 18:59:21 -0500
Date: Sun, 20 Jan 2002 00:00:24 +0000
From: Dave Jones <davej@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.2-dj3
Message-ID: <20020120000024.A16716@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clear the backlog of small pending bits ready for the next resync.

Patch against 2.5.2 vanilla is available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/
(Whilst kernel.org is on sick leave, this is also available on
 http://www.codemonkey.org.uk/patches/2.5/patch-2.5.2-dj3.diff.gz)


 -- Davej.

2.5.2-dj3
o   Remove/Add some mismerged bits.			(Me)
o   Reiserfs rename fixes.				(Oleg Drokin)
o   Remove 2.4 only netdriver changes.			(Jeff Garzik, Me)
o   Scheduler update to J2				(Ingo Molnar)
o   GUID partition support update.			(Matt Domsch)
o   Configure help entries for IDE.			(Andre Hedrick, Rob Radez,
							 Anton Altaparmakov)
o   Reduce NTFS vmalloc use.				(Anton Altaparmakov)
o   Parallel port SCSI zip driver update.		(derek@signalmarketing.com)
o   Iforce & Vortex joystick compile fix.		(James Simmons)
o   IDE Tape driver bio fixes.				(Frank Davis)
o   i820 & i830mp AGPGart & APM fix.			(Nicolas Aspert)
o   i820up AGPGart recognition.				(Daniele Venzano)
o   Radeonfb 1400x1050 mode timings.			(Michael Clark)


2.5.2-dj2
o   Merge 2.4.18pre4
o   Remove duplicate soundblaster ISAPNP ID.		(Jeff Garzik)
o   devexit fix for dmfe.				(Jeff Garzik)
o   Multiport tulip irq assignment fix.			(Christoph Dworzak)
o   Small include file cleanup.				(Andi Kleen)
o   message cleanup of fatfs				(OGAWA Hirofumi)
o   GUID Partition Tables support.			(Matt Domsch)
o   Hyperthreading support for MTRR.			(Sunil Saxena)
o   More fbdev infrastructure work.			(James Simmons)
o   Numerous advansys driver fixes.			(Douglas Gilbert)
o   buffer.c thinko.					(Andrew Morton)
o   Fix ramdisk compile breakage.			(Me)
o   Fix acpitable.c mapping problems.			(James Cleverdon)
o   Input layer reworking.				(James Simmons,
							 Vojtech Pavlik)
o   Netfilter build fix.				(Steven Cole)
o   ATA PIO & Multimode fixes.				(Jens Axboe)
o   Update scheduler to J0.				(Ingo Molnar, others)
o   fbdev colormap cleanup.				(James Simmons)


2.5.2-dj1
o   Merge 2.5.2 final.
o   Merge 2.5.3pre1
o   Numerous compile fixes.				(Various)
o   Fix crc32 JFFS2 problem.				(Russell King)
o   Remove left over ARM bits from 2.5.1-dj15.		(Me)
o   Mips Magnum fb compile fix.				(Me)
o   Update to sched-I3					(Ingo Molnar)
o   Add missing cp1250 file.				(Me)


2.5.1-dj15
o   Merge selective bits of 2.4.18pre3ac1 & ac2
    | Drop rmap (except for rate-limit oom_kill change),
    | IDE changes & 32bit uid quota
o   Add 'nowayout' module param for watchdogs.		(Matt Domsch)
o   BSD partition fixes.				(Andries Brouwer)
o   wavelan_cs update					(Jean Tourrilhes)
o   Numerous LVM fixes.					(andersg)
o   Prevent ramdisk buffercache corruption.		(Andrea Arcangeli)
o   MS_ASYNC implementation.				(Andrea, Andrew Morton)
o   Truncate blocks when prepare_write() fails.		(Andrea, Andrew Morton)
o   winbond-840 OOM handling.				(Manfred Spraul)
o   Natsemi OOM handling.				(Manfred Spraul)
o   Eliminate some stalls in i386 syscall path.		(Alex Khripin)
o   Export release_console_sem()			(Andrew Morton)
o   Remove bogus sbp2 changes.				(Christoph Hellwig)
o   Remove i386 mmu_context.h				(Me)
o   Remove reiserfs build warnings.			(Me)
o   Fix ignorance of SCSI I/O errors.			(Peter Osterlund)
o   Fix IDE floppy thinko.				(Luc Van Oostenryck)
o   Radeonfb compile fixes.				(Erik Andersen)
o   Radeonfb flat panel support.			(Michael Clark)
o   Remove bogus extraneous return.			(Paul Gortmaker)
o   Fix potential oom-killer race.			(Andres Salomon)
o   Fix bio + highmem bounce BUG().			(Jens Axboe)
o   PATH_MAX fixes.					(Rusty Russell)
o   Frame buffer _setcolreg changes.			(James Simmons)


-- 
Dave Jones.                    http://www.codemonkey.org.uk
SuSE Labs.
