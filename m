Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314290AbSD0RH4>; Sat, 27 Apr 2002 13:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314291AbSD0RHz>; Sat, 27 Apr 2002 13:07:55 -0400
Received: from revdns.flarg.info ([213.152.47.19]:50828 "EHLO noodles.internal")
	by vger.kernel.org with ESMTP id <S314290AbSD0RHz>;
	Sat, 27 Apr 2002 13:07:55 -0400
Date: Sat, 27 Apr 2002 18:07:37 +0100
From: Dave Jones <davej@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.5-dj merging status.
Message-ID: <20020427170737.GA29275@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just pushed the best part of another 1MB worth of bits
to Jeff & Linus, in the vain hope of getting my tree under 5MB
away from mainline by the end of the month (yeah right).

Anyway. here's a list of some of the bigger pieces that are left
in my tree, along with the grand merging masterplan..

Hopefully by the end of the weekend, quite a few more from the
pending list will also be gone Linuswards.

	Dave.


+ means this has gone to Linus or Jeff Garzik today.

Pending:
+   hch's kthread abstraction
+   hch's kill obsolete blk.h bits
+   bgersts romfs sb cleanup
+   manfreds dynamic ldt
+   Death of SYMBOL_NAME pt.1
+   numerous jiffy wrap fixes
+   Numerous network driver fixes
o   x86 io.h cleanup
o   SIGIO FIFO/Pipes
o   lots of request_region cleanups
o   several remaining strtok -> strsep conversions
o   various suser -> capability checks
o   lots of silly bits, like missing MODULE_LICENSE tags
o   Lots of documentation/Config.help updates
o   floppy driver & PNPBIOS interaction fix.
o   Several POSIX/SUS compliance fixes
o   Randy's ikconfig
o   Yet more kdev_t fixes.
o   Several new watchdog drivers.
o   Various filesystem updates from 2.4


Being pushed by maintainer:
o   New framebuffer code	(~2MB)
o   New input layer		(~1MB)
o   New console/tty layer	(~512KB)
o   ALSA OSS fixes.		(~512KB)


Won't merge:
o   VM updates from 2.4.x.


Won't merge unless asked by $maintainer
o   Manfreds OOM handling for winbond NIC
o   Various wireless NIC updates.
o   SiS DRM
o   MTD updates


Things unlikely to merge yet:
o   mikaels UP micro-optimisation
o   SCSI error handling breakage
o   Various SCSI driver updates
    | Doug is sorting through these


Things to drop soon.
o   AACRAID (Alan will merge when ready)
o   Bits from m68k and other niche architectures.
    | $Maintainers already have these bits, and will take care of later.
o   Some of the 2.4 VM bits.

