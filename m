Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292637AbSBUQbr>; Thu, 21 Feb 2002 11:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292641AbSBUQbi>; Thu, 21 Feb 2002 11:31:38 -0500
Received: from noodles.codemonkey.org.uk ([62.49.180.5]:31423 "EHLO
	noodles.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id <S292637AbSBUQbb>; Thu, 21 Feb 2002 11:31:31 -0500
Date: Thu, 21 Feb 2002 16:35:26 +0000
From: Dave Jones <davej@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.5-dj1
Message-ID: <20020221163526.A22035@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mostly just syncing with Linus, plus the next round of small bits.
I backed out the IDE changes for various reasons, handle with
care in case I missed something.

Patch against 2.5.5 vanilla is available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/

By popular request, the curious can now find most of what
was merged in each release at http://www.codemonkey.org.uk/patches/merged/

 -- Davej.

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
