Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317605AbSFRUbN>; Tue, 18 Jun 2002 16:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317607AbSFRUbM>; Tue, 18 Jun 2002 16:31:12 -0400
Received: from revdns.flarg.info ([213.152.47.19]:52936 "EHLO noodles.internal")
	by vger.kernel.org with ESMTP id <S317605AbSFRUbL>;
	Tue, 18 Jun 2002 16:31:11 -0400
Date: Tue, 18 Jun 2002 21:32:13 +0100
From: Dave Jones <davej@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.22-dj1
Message-ID: <20020618203213.GA25878@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Resync with mainline, and get most of the big bits out of the patch queue.
Quite a large amount of changes, so I've held back the remainder of
those in the queue until next time.

As usual,..

Patch against 2.5.22 vanilla is available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/

Merged patch archive: http://www.codemonkey.org.uk/patches/merged/

Check http://www.codemonkey.org.uk/Linux-2.5.html before reporting
known bugs that are also in mainline.

 -- Davej.

2.5.22-dj1
o   Drop bogus warning printk from shmem option parser.	(Hugh Dickins)
o   Only allow IGMP packets to multicast addresses.	(Krishna Ramachandran)
o   Back out NFS READDIRPLUS patch pending investigation.
o   aic7xxx has new style error handling.		(Me)
o   ISDN CAPI config fixes.				(Carsten Rietzschel)
o   Add SiS 7012 to i8x0 audio compatables.		(Carsten Rietzschel)
o   Fix asm constraints in RAID5 XOR functions.		(Andi Kleen)
o   Kill off FAT CVF support.				(OGAWA Hirofumi)
o   Fix up several compilation warnings.		(Rudmer van Dijk)
o   Region handling fixups for tcic, ixj		(William Stinson)
o   More list_del_init cleanups.			(Brian Gerst)
o   Cleanup floppy fixes.				(Mikael Petterson)
    | note VFS & floppy still known to be broken.
o   Keep max_scsi_host synced with scsi_host_no_list	(Itai Nahshon)
o   Introduce scsimon driver.				(Douglas Gilbert)
o   Cleanup ini9100u scsi driver.			(Douglas Gilbert)
o   Remove VM_FAULT magic numbers.			(William Lee Irwin)
o   Fix oops on dual head matroxfb.			(Petr Vandrovec)
    | 2.5-dj framebuffer code is lagging mainline quite a bit.
o   allow_dma option for OPL3Sa4 cards.			(Gerald Teschl)
o   Mark OPL3sax cards always use opl3sa2 driver.	(Gerald Teschl)
o   GRE initialisation fix.				(Sam Ravnborg)
o   Fix 'make tags' to include all dirs.		(Kai Germaschewski)
o   EPERM->EACCESS in ext2/ext3_ioctl.			(Andreas Dilger)
o   Further LVM fixes.					(Anders Gustafsson)
o   Compile fixes for SCSI & CS46xx.			(Stephen Rothwell)
o   Andrew Morton jumbo-patch-o-rama.			(Andrew Morton)
o   Unbotch IDE TCQ locking.				(Jens Axboe)
o   rio kdev_t compile fixes.				(Adrian Bunk)
o   Fix modversions.					(Kai Germaschewski)
o   Remove detritus from menuconfig on clean.		(Kai Germaschewski)
o   Fix initrd breakage.				(Mikael Petterson)
o   Fix copy_from_user bogon in sb_audio		(Mikael Petterson)
o   Hotplug PCI compilation fix.			(Matthew Harrell)

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
