Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261774AbSI2UQz>; Sun, 29 Sep 2002 16:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261766AbSI2UQa>; Sun, 29 Sep 2002 16:16:30 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:39820 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261761AbSI2UPX>;
	Sun, 29 Sep 2002 16:15:23 -0400
Date: Sun, 29 Sep 2002 21:24:16 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.39-dj1
Message-ID: <20020929202416.GA1518@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's been a while since I did one of these, and with so many
pending patches in my queue, a large 2.4 sync, and a number
of people asking for the status of various code/merges, I
thought I'd put up a state-of-play diff.
Quite a bit in here (and lots more pending), passes the
scientific "it boots" test, but as always, tread carefully.
I'll try and pick up the pace again as before, but with various
other work related projects looming, we'll see how things go..

As usual,..

Patch against 2.5.39 vanilla is available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/

 -- Davej.

2.5.39-dj1
o   Merge bits of 2.4.20pre up to pre8
o   Drop more silly bits found whilst syncing with Linus.
o   Drop old-style cpufreq
    | new-style merge pending.
o   Fix reiserfs alloc= mount option parser		(Oleg Drokin)
o   Remove obsolete GFP_NFS				(Matthew Wilcox)
o   Leave reserved APIC bit untouched on P4.		(Zwane Mwaikambo)
o   Remove preempt warnings on shutdown/reboot.		(Robert Love)
o   Fix UP_APIC linkage problem				(Mikael Pettersson)
o   Fix bootmem page merging off by one.		(Juan M. de la Torre)
o   Netfilter sleeping allocation under spinlock fix.	(James Morris)
o   Fix ACPI thermal throttling.			(Pavel Machek)
o   Make background MCE checker preempt safe on UP too.	(Me)
o   Add extra Pentium 4 idents.				(Me)
o   Restore an optimisation to locks.c			(Matthew Wilcox)
o   Add missing kill_sb to futexfs			(Marc Zyngier)
o   Merge new reiserfs block allocator.			(Alexander Zarochencev,
							 Jeff Mahoney,
							 Oleg Drokin.)
o   Remove LVM infection in <linux/list.h>		(Me)
o   Configurable list_head sanity checks.		(Zach Brown, Me)
    | Munged a bit by me, and based on Zab's first post.
    | Will merge updated version later.
o   Fix 8250_pci oops on shutdown.			(Patrick Mochel)
o   SiS DRM kmalloc sanity checks.			(Zwane Mwaikambo)
o   Add Sony DSC-P5 to USB unusual devs list.		(?)
    | rediscovered misplaced patch.
o   Print tracer PID in /proc/<pid>/status		(Daniel Jacobowitz)
o   3ware driver updates.				(Adam Radford)
o   devfs compile fixes.				(Olaf Dietsche)
o   Various __FUNCTION__ pasting fixes.			(Paul Larson, Adrian Bunk,
							 Alessandro Suardi)
o   Named struct initialisers for sunrpc.		(Chuck Lever)
o   Make sleep-under-spinlock a CONFIG_DEBUG_ option.	(Me)
o   Atari IDE locking fix.				(Geert Uytterhoeven)
o   Fix debugging message in rwsem spinlocks.		(Geert Uytterhoeven)

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
