Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285023AbSAZOnh>; Sat, 26 Jan 2002 09:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285060AbSAZOn2>; Sat, 26 Jan 2002 09:43:28 -0500
Received: from noodles.codemonkey.org.uk ([62.49.180.5]:21977 "EHLO
	noodles.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id <S285023AbSAZOnO>; Sat, 26 Jan 2002 09:43:14 -0500
Date: Sat, 26 Jan 2002 14:43:41 +0000
From: Dave Jones <davej@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.2-dj6
Message-ID: <20020126144341.A24679@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This catches up with -Linus and Marcelo, and contains various
other updates. Things of note include dropping all my previous
reiserfs changes in favour of a large official update from Oleg & co.

My Configure.help changes have also been mostly dropped except
in a few cases. These will get merged back in over time, they were
left out for now as pre5 lost all the 'choice' type questions.
When they reappear in pre6 hopefully, I'll re-add my changes.

Patch against 2.5.2 vanilla is available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/

 -- Davej.

2.5.2-dj6
o   Merge 2.5.3pre5
o   Merge 2.4.18pre7
o   Fix pci_unmap_addr_SET typo.			(David S. Miller)
o   Make dl2k driver use generic crc function.		(Jim McDonald)
o   Revoke 007's right to kill.				(John Levon)
o   Drop i2oblock changes on Alans request.
o   removes gcc-2.4.5 workaround.			(Adrian Bunk)
o   Further input/usb updates.				(Vojtech Pavlik)
o   Trigraph warning cleanup for wavelan_cs.		(Jean Tourrilhes)
o   driverfs support for USB.				(Greg KH)
o   ext2 FS corruption fix.				(Alexander Viro)
o   Work around reiserfs kmem_cache_create() problem.	(Andi Kleen)
o   CONFIG_MELAN typo in i386/setup.c			(Robert Schwebel)
o   Scheduler update to J7.				(Ingo Molnar)
o   Some Config.help / Config.in cleaning.		(Me)
o   Reiserfs update.					(Oleg Drokin et al)
    | Oleg, not all of this applied. I'll do the rest by
    | hand next time.
o   Convert PnPBIOS to use new subsys_initcall()	(Me)
o   Move screen_base to struct fb_info			(James Simmons)
o   Preliminary EISA support for driverfs.		(Me)
    | don't take this too seriously yet, it needs work.
o   UFS blocksize fix.					(Zwane Mwaikambo)


2.5.2-dj5
o   Merge 2.5.3-pre3
o   Merge 2.4.18pre6
o   ieee1394 videodev compile fix.		(Frank Davis)
o   Removed bogus CVSIDs			(Eagle eye Christoph Hellwig)
o   Register EISA io ports.			(Paul Gortmaker, me)	
o   Various APM tweaking.			(Stephen Rothwell, others)
o   Skeleton PCI hotplug driver.		(Greg KH)
o   Make IMM driver work again.			(Rich Baum)
o   PPC idleloop bugfix.			(Rusty Russell)
o   Fix USB mouse modular compile.		(Greg KH)
o   Make fbgen compile modular.			(Various)
o   Fix SMP kernel on UP boot.			(Al Viro)
o   Plug usb_make_path memory leaks		(Greg KH)
o   Only incr io_count on bio_alloc success.	(Badari Pulavarty)
o   Fix block backed loop mounts.		(Adam Richter)
o   DAC960 bio changes.				(Jim McDonald)
o   i2o block bio changes.			(Jim McDonald)


2.5.2-dj4
o   Merge 2.5.3-pre2
o   Scheduler update to J4.			(Ingo Molnar)
o   Input layer updates.			(Vojtech Pavlik, James Simmons)
o   Matroxfb Configure.help updates.		(Robert love)
o   Framebuffer colourmap improvements.		(James Simmons)
o   Fix FAT infinite loops.			(OGAWA Hirofumi)
o   Various compile fixes.			(Me)
o   Small cpqarray cleanup.			(Me)
o   devfs fixes.				(Richard Gooch)
    | should fix the no-booting problem some people saw.
o   ipv6 endian fixes.				(Russell King)
o   Make AFFS fsx-proof.			(Roman Zippel)


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
