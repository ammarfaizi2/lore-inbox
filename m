Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315446AbSEHWvN>; Wed, 8 May 2002 18:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315473AbSEHWvM>; Wed, 8 May 2002 18:51:12 -0400
Received: from revdns.flarg.info ([213.152.47.19]:62084 "EHLO noodles.internal")
	by vger.kernel.org with ESMTP id <S315446AbSEHWvK>;
	Wed, 8 May 2002 18:51:10 -0400
Date: Wed, 8 May 2002 23:51:47 +0100
From: Dave Jones <davej@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.14-dj2
Message-ID: <20020508225147.GA11390@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some more pending items, including a large patch from Patrick
which splits the x86 CPU initialisation code up a lot, cleaning
up a lot of cruft in the process. Feedback on this welcomed from
users of as many weird and wonderful x86 variants as can be found.

As usual,..
Patch against 2.5.14 vanilla is available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/

Merged patch archive: http://www.codemonkey.org.uk/patches/merged/

Check http://www.codemonkey.org.uk/Linux-2.5.html before reporting
known bugs that are also in mainline.

 -- Davej.

2.5.14-dj2
o   Split up x86 CPU initialisation.			(Patrick Mochel,
							 Mark Haverkamp)
o   Drop aic7xxx changes, and aacraid.
o   tlb_state alignment tweak.				(Me)
o   Use centralised ALIGN macro in depca driver.	(Peter Denison)
o   Missing header in nfsroot.				(David Gibson)
o   Use standard AS rules for x86 arch.			(Steven Rothwell)
o   smp_call_function bh context changes for non-x86	(Dipankar Sarma)
o   IDE patches up to -58.				(Martin Dalecki)
o   Fix IOAPIC compile problem.				(Mikael Pettersson)
o   Update remaining references to egcs.		(Adrian Bunk)
o   Add some missing __init's to x86 smpboot.		(Andrey Panin)
o   Fix invalid koi8-ru NLS return codes.		(Petr Vandrovec)
o   Set up default NLS mapping for unknown encodings.	(Petr Vandrovec)
o   Improved romfs superblock cleanup.		(Christoph Hellwig)
o   Fix compile problem with IOVIRT debug + MULTIQUAD.	(Martin J. Bligh)
o   RTC driver region cleanup.				(William Stinson)
    | Munged a bit by me.
o   Various NBD improvements.				(Steven Whitehouse)
o   3c509 Full duplex support.				(David Ruggiero)


2.5.14-dj1
o   Don't prefetch memcpy's to/from io addresses.	(Me)
o   Fix MMX prefetching for x86-64			(Me)
o   Other small MMX copying tweaks for x86-64.		(Me)
o   Drop more silly bits found whilst patch splitting.
o   Fix tcq brown paper bag bug.			(Jens Axboe)
o   OSS API emulation config.in thinko.			(Jaroslav Kysela)
o   Update to IDE-55					(Martin Dalecki)
o   Disallow compilation with gcc 2.91.66		(Andrew Morton)
o   Missed blksize cleanup in rd.c			(Al Viro)
o   NTFS compile fix.					(Andrew Morton)
o   More futex updates.					(Rusty Russell)
o   DE600 region checking cleanup.			(William Stinson)
o   Update VIA quirk URL.				(Erich Schubert)
o   Fix up a few _llseek prototypes.			(Frank Davis)
o   Move busmouse BKL usage to correct place.		(Frank Davis)
o   __d_lookup() microoptimisation.			(Paul Menage)	
o   Fix CAP_SYS_RAWIO thinko for cpqfcTSinit		(Christoph Hellwig)
o   malloc.h -> slab.h for pc300_tty			(Adrian Bunk)
o   Add CONFIG_BROKEN_SCSI_ERROR_HANDLING		(Me)
    | Those who don't care about their data can now
    | choose the same behaviour as mainline.


-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
