Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265102AbSJaCCN>; Wed, 30 Oct 2002 21:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265103AbSJaCCN>; Wed, 30 Oct 2002 21:02:13 -0500
Received: from dp.samba.org ([66.70.73.150]:57259 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265102AbSJaCCL>;
	Wed, 30 Oct 2002 21:02:11 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: What's left over.
Date: Thu, 31 Oct 2002 13:07:15 +1100
Message-Id: <20021031020836.E576E2C09F@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

	Here is the list of features which have are being actively
pushed, not NAK'ed, and are not in 2.5.45.  There are 13 of them, as
appropriate for Halloween.

	Most were submitted repeatedly *well* before the freeze.  It'd
be nice for you to give feedback, and decide which ones (if any) are
still up for review.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

From: http://www.kernel.org/pub/linux/kernel/people/rusty/2.6-not-in-yet/

Rusty's Remarkably Unreliable List of Pending 2.6 Features
[aka. Rusty's Snowball List]

A: Author
M: lkml posting describing patch
D: Download URL
S: Size of patch, number of files altered (source/config), number of new files.
X: Impact summary (only parts of patch which alter existing source files, not config/make files)
T: Diffstat of whole patch
N: Random notes

In rough order of invasiveness (number of altered source files):

In-kernel Module Loader and Unified parameter support
A: Rusty Russell
D: http://www.kernel.org/pub/linux/kernel/people/rusty/patches/Module/
S: 841 kbytes, 302/36 files altered, 22 new
T: Diffstat
X: Summary patch (598k)
N: Requires new modutils

Fbdev Rewrite
A: James Simmons
M: http://www.uwsg.iu.edu/hypermail/linux/kernel/0111.3/1267.html
D: http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz
S: 4852 kbytes, 168/29 files altered, 124 new
T: Diffstat
X: Summary patch (182k)

Linux Trace Toolkit (LTT)
A: Karim Yaghmour
M: http://www.uwsg.iu.edu/hypermail/linux/kernel/0204.1/0832.html
M: http://marc.theaimsgroup.com/?l=linux-kernel&m=103491640202541&w=2
M: http://marc.theaimsgroup.com/?l=linux-kernel&m=103423004321305&w=2
M: http://marc.theaimsgroup.com/?l=linux-kernel&m=103247532007850&w=2
D: http://opersys.com/ftp/pub/LTT/ExtraPatches/patch-ltt-linux-2.5.44-vanilla-021026-2.2.bz2
S: 257 kbytes, 67/4 files altered, 9 new
T: Diffstat
X: Summary patch (90k)

statfs64
A: Peter Chubb
M: http://marc.theaimsgroup.com/?l=linux-kernel&m=103490436228016&w=2
D: http://marc.theaimsgroup.com/?l=linux-kernel&m=103490436228016&w=2
S: 42 kbytes, 53/0 files altered, 1 new
T: Diffstat
X: Summary patch (32k)

ext2/ext3 ACLs and Extended Attributes
A: Ted Ts'o
M: http://lists.insecure.org/lists/linux-kernel/2002/Oct/6787.html
B: bk://extfs.bkbits.net/extfs-2.5-update
D: http://thunk.org/tytso/linux/extfs-2.5/
S: 497 kbytes, 96/34 files altered, 34 new
T: Diffstat
X: Summary patch (167k)

ucLinux Patch (MMU-less support)
A: Greg Ungerer
M: http://lwn.net/Articles/11016/
D: http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.44uc3.patch.gz
S: 2218 kbytes, 25/34 files altered, 429 new
T: Diffstat
X: Summary patch (40k)

Crash Dumping (LKCD)
A: Matt Robinson, LKCD team
M: http://lists.insecure.org/lists/linux-kernel/2002/Oct/8552.html
D: http://lkcd.sourceforge.net/download/latest/
S: 18479 kbytes, 18/10 files altered, 10 new
T: Diffstat
X: Summary patch (18k)

POSIX Timer API
A: George Anzinger
M: http://marc.theaimsgroup.com/?l=linux-kernel&m=103553654329827&w=2
D: http://unc.dl.sourceforge.net/sourceforge/high-res-timers/hrtimers-posix-2.5.44-1.0.patch
S: 66 kbytes, 18/2 files altered, 4 new
T: Diffstat
X: Summary patch (21k)

Hotplug CPU Removal Support
A: Rusty Russell
D: http://www.kernel.org/pub/linux/kernel/people/rusty/patches/Hotcpu/hotcpu-cpudown.patch.gz
S: 32 kbytes, 16/0 files altered, 0 new
T: Diffstat
X: Summary patch (29k)

Hires Timers
A: George Anzinger
M: http://marc.theaimsgroup.com/?l=linux-kernel&m=103557676007653&w=2
M: http://marc.theaimsgroup.com/?l=linux-kernel&m=103557677207693&w=2
M: http://marc.theaimsgroup.com/?l=linux-kernel&m=103558349714128&w=2
D: http://unc.dl.sourceforge.net/sourceforge/high-res-timers/hrtimers-core-2.5.44-1.0.patch http://unc.dl.sourceforge.net/sourceforge/high-res-timers/hrtimers-i386-2.5.44-1.0.patch http://unc.dl.sourceforge.net/sourceforge/high-res-timers/hrtimers-hrposix-2.5.44-1.1.patch
S: 132 kbytes, 15/4 files altered, 10 new
T: Diffstat
X: Summary patch (44k)
N: Requires POSIX Timer API patch

EVMS
A: EVMS Team
M: http://www.uwsg.iu.edu/hypermail/linux/kernel/0208.0/0109.html
D: http://evms.sourceforge.net/patches/2.5.44/
S: 1101 kbytes, 7/10 files altered, 44 new
T: Diffstat
X: Summary patch (4k)

initramfs
A: Al Viro
M: http://www.cs.helsinki.fi/linux/linux-kernel/2001-30/0110.html
D: ftp://ftp.math.psu.edu/pub/viro/N0-initramfs-C21
S: 16 kbytes, 5/1 files altered, 2 new
T: Diffstat
X: Summary patch (5k)

Kernel Probes
A: Vamsi Krishna S
M: lists.insecure.org/linux-kernel/2002/Aug/1299.html
D: http://www.kernel.org/pub/linux/kernel/people/rusty/patches/Misc/kprobes.patch.gz
S: 18 kbytes, 4/2 files altered, 4 new
T: Diffstat
X: Summary patch (5k)
