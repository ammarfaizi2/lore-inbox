Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315101AbSECS6K>; Fri, 3 May 2002 14:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315653AbSECS6J>; Fri, 3 May 2002 14:58:09 -0400
Received: from revdns.flarg.info ([213.152.47.19]:36755 "EHLO noodles.internal")
	by vger.kernel.org with ESMTP id <S315101AbSECS6J>;
	Fri, 3 May 2002 14:58:09 -0400
Date: Fri, 3 May 2002 19:58:11 +0100
From: Dave Jones <davej@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.13-dj1
Message-ID: <20020503185811.GA4846@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Back up to date with the other trees of the day, clear out some more
of the pending queue, some more shrinkage, and drop some more silly bits
that were spotted during patch splitting.

Size seems to be creeping up dramatically, but this is largely
due to large updates like the IDE bits (which will show up in .14 anyway)
Other big chunks are on their way to Linus later..

As usual,..
Patch against 2.5.13 vanilla is available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/

Merged patch archive: http://www.codemonkey.org.uk/patches/merged/

Check http://www.codemonkey.org.uk/Linux-2.5.html before reporting
known bugs that are also in mainline.

 -- Davej.
 
2.5.13-dj1
o   Merge 2.4.19pre7 & pre8
    | drop non-x86 archs, cpqarray update, watchdog bits, LARGE ips update
o   Back out bogus ext2_setup_super() change.
o   EFI RTC region handling cleanup.			(William Stinson)
o   Create stub for thermal_interrupt.			(Brian Gerst)
o   ADFS super_block cleanup.				(Brian Gerst)
o   UFS super_block cleanup.				(Brian Gerst)
o   IDE-49 changes.					(Martin Dalecki)
o   hpt34x compile fix.					(Martin Dalecki)
o   Add some missing MODULE_LICENSE tags to fs/		(Tomas Szepe)
o   Check request_irq in atari_lance			(William Stinson)
o   Update error handling for AHA1542			(Douglas Gilbert)
o   Small umem fixes/cleanup.				(Neil Brown)
o   Small ALSA compilation fix.				(Jaroslav Kysela)
o   Missing includes in sd/scsi_debug			(Russell King)
o   Add missing NIPQUAD conversion to nfsroot.		(Trond Myklebust)
o   IDE-50 and IDE-51.					(Martin Dalecki)
o   Missing MODULE_LICENSE for sisfb.			(John Tyner)
o   request_region cleanup for AHA1542			(William Stinson)
o   Sync framebuffer code with mainline.		(James Simmons)



-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
