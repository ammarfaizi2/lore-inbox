Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292682AbSBZWav>; Tue, 26 Feb 2002 17:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292688AbSBZWal>; Tue, 26 Feb 2002 17:30:41 -0500
Received: from noodles.codemonkey.org.uk ([62.49.180.5]:14730 "EHLO
	noodles.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id <S292682AbSBZWac>; Tue, 26 Feb 2002 17:30:32 -0500
Date: Tue, 26 Feb 2002 22:34:06 +0000
From: Dave Jones <davej@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.5-dj2
Message-ID: <20020226223406.A26905@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Right up to date with Marcelo & Linus, and clear inbound patch queue.
Despite the growing size, resync with Linus is still in progress,
and some of the bigger bits have now either shown up in pre1, or
are queued to go his way real soon.

Patch against 2.5.5 vanilla is available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/

By popular request, the curious can now find most of what
was merged in each release at http://www.codemonkey.org.uk/patches/merged/

 -- Davej.

2.5.5-dj2
o   Merge 2.5.6pre1
o   Merge up to 2.4.19pre1
o   Merge IDE changes from 2.5.5
o   Drop S390 changes.
    | These were incomplete & old, and would be better
    | merged by the maintainers anyway.
o   Fix decvte console graphic mode.			(Nick Pasich)
o   Chop non x86-64 bits out of x86-64 mtrr.c		(Me)
o   Eliminate annoying warning in serial.c		(Andrey Panin)
o   Use named initialisers in various filesystems.	(Todor Todorov)
o   More devexit fixes.					(Andrew Morton)
o   Fix null pointer checks in sd.c			(Peter Wong)
o   Further multi-desktop console work.			(James Simmons)
o   Docbook compile fixes.				(Erlend Aasland)
o   Additional Config.help texts.			(Dan Carpenter,
							 Steven Cole)
o   Convert neofb to new framebuffer api.		(James Simmons)
o   Sanitise arguments to mempool_create()		(Balbir Singh)
o   Fix binfmt_elf modular compile.			(Paul Gortmaker)
o   Only fsync() blockdev on last close/umount.		(Miquel van Smoorenburg)
o   Promise IDE driver update.				(Peter Denison)
o   irq router recognition for Intel ICH chipsets.	(Wim Van Sebroeck)
o   IPv6 initialisation workaround.			(Ben Clifford)
    | Works, but may not be correct fix.
o   Dump x86 MCE MISC register in right order.		(Me)
o   NFSv3->NFSv2 READDIRPLUS fix.			(Trond Myklebust)
o   More /proc/net signedness fixes.			(Arnaud Giersch)
o   Fix JFFS2 duplicate slabcache name.			(Me)
o   mtdblock bio work.					(Me)
    | Quick hack to test JFFS2 changes, WorksForMe(tm).
o   Various other small MTD/JFFS2 fixes.		(Me)
o   sstfb support for interlace / doublescan modes.	(Urs Ganse)
o   Use correct timings for PIIX secondary slave.	(Daniel Quinlan)
o   Fix up some borken comments.			(John Kim)


2.5.5-dj1
o   Merge 2.5.5 final.
    | Backout broken IDE changes.
o   Implement proper locking in ALSA lseek methods.	(Robert Love)
o   Document lseek locking.				(Robert Love)
o   ALSA + YMFPCI compile fixes.			(Stelian Pop)
o   Further console reentrancy work.			(James Simmons)
o   NFS compile fix.					(Neil Brown)
o   Fix up some strsep changes from last time.		(René Scharfe)
o   tmpfs link-count on dir rename fixes.		(Christoph Rohland)
o   USB vicam driver build fixes.			(Greg KH)
o   Split up terminal emulation.			(James Simmons)
o   Fix scsi_merge crash-on-boot problem.		(Jens Axboe)


2.5.4-dj3
o   Merge up to 2.4.18rc2
o   Change <linux/malloc.h> -> <linux/slab.h>	(Me)
o   Fix borken locking in nfs ->lookup.		(Jarno Paananen)
o   Fix ext2 freeing blocks not in datazone.	(Randy Hron, Chris Wright)
o   Fix ext2/ext3 revision level checks.	(Andreas Dilger)
o   Fix ramdisk compilation failure.		(Me, Rudmer van Dijk)
o   More include dependancy tweaks.		(Me)
o   BSS janitor work.				(Craig Christophel)
o   Replace all strtok users with strsep.	(Matthew Hawkins, Jason Thomas)
o   scsi_debug ->address & other fixes.		(Douglas Gilbert)
o   Silence isapnp debug messages.		(Andrey Panin)
o   Clear passcred in sock_alloc()		(OGAWA Hirofumi)
    | Fixes slow sunrpc/portmap, and various
    | gnome-terminal weirdness.
o   Console reentrancy work.			(James Simmons)
o   ALSA Config.in fixes.			(René Scharfe)
o   Fix Oxford Semiconductor PCI id.		(Ed Vance)
o   Power Management for es18xx.		(Zwane Mwaikambo)
o   Remove duplicate PCI ids.			(Wim Van Sebroeck)
o   Change Olympic driver to use spinlocks.	(Mike Phillips)
o   Fix pcilynx locking.			(Manfred Spraul)
o   Fix cris eeprom driver locking.		(Robert Love)
o   PPP/BSD Compression vfree in interrupt fix.	(Paul Mackerras,
						 Dominik Brodowski)
o   cli->spinlocks for aha1542 driver.		(Douglas Gilbert)
o   ALSA ISAPNP fixes.				(Andrey Panin)
o   /proc/net/udp signedness fix.		(Arnaud Giersch)
o   fcntl_[gs]etlk* cleanup.			(Chris Wright)


-- 
Dave Jones.                    http://www.codemonkey.org.uk
SuSE Labs.
