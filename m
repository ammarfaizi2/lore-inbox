Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262239AbSJ1IgT>; Mon, 28 Oct 2002 03:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262906AbSJ1IgT>; Mon, 28 Oct 2002 03:36:19 -0500
Received: from dp.samba.org ([66.70.73.150]:60120 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262239AbSJ1IgR>;
	Mon, 28 Oct 2002 03:36:17 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
Subject: Rusty's Remarkably Unreliable 2.6 List
Date: Mon, 28 Oct 2002 19:42:10 +1100
Message-Id: <20021028084237.CBA282C0A0@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

	Yet another unofficial list of non-trivial features pending
which are "ready to go" and not already in:

	http://www.kernel.org/pub/linux/kernel/people/rusty/2.6-not-in-yet/

Features include Remarkably Unreliable Invasiveness Meter, and
"executive summary patch" which shows existing source code which is
effected.

If anyone has a direct URL for EVMS or LVM2 against a recent kernel,
please provide.

Current list reproduced below,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

================
Rusty's Remarkably Unreliable List of Pending 2.6 Features

Hi. I'm bitter because my module rewrite didn't get in earlier, so now
I'm spending some effort to ensure that there's a one-stop list of
patches which might go into 2.6, making it easier to review, argue,
and ideally allow Linus to decide what is to be considered for the
freeze.

Entrance criteria:

    * Must have been submitted to lkml in the last month,
    * Hasn't been rejected by the maintainer/Linus,
    * Not appropriate for insertion during stable series (ie. too invasive, new feature, breaks userspace)

Key:
A: Author
M: lkml posting describing patch
D: Download URL
S: Size of patch, number of files altered (source/config), number of new files.
X: Exective summary (only parts of patch which alter existing source files, not config/make files)
N: Random notes

In rough order of invasiveness (number of altered source files):

Fbdev Rewrite
A: James Simmons
M: http://www.uwsg.iu.edu/hypermail/linux/kernel/0111.3/1267.html
D: http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz
S: 4852 kbytes, 161/36 files altered, 124 new
X: Summary patch (182k)

In-kernel Module Loader and Unified parameter support
A: Rusty Russell
D: http://www.kernel.org/pub/linux/kernel/people/rusty/patches/Module/
S: 760 kbytes, 121/15 files altered, 22 new
X: Summary patch (539k)
N: Requires new modutils

Linux Trace Toolkit (LTT)
A: Karim Yaghmour
M: http://www.uwsg.iu.edu/hypermail/linux/kernel/0204.1/0832.html
M: http://marc.theaimsgroup.com/?l=linux-kernel&m=103491640202541&w=2
M: http://marc.theaimsgroup.com/?l=linux-kernel&m=103423004321305&w=2
M: http://marc.theaimsgroup.com/?l=linux-kernel&m=103247532007850&w=2
D: http://opersys.com/ftp/pub/LTT/ExtraPatches/patch-ltt-linux-2.5.44-vanilla-021019-2.2.bz2
S: 255 kbytes, 68/3 files altered, 9 new
X: Summary patch (90k)

ext2/ext3 ACLs and Extended Attributes
A: Ted Ts'o
M: http://lists.insecure.org/lists/linux-kernel/2002/Oct/6787.html
B: bk://extfs.bkbits.net/extfs-2.5-update
D: http://thunk.org/tytso/linux/extfs-2.5/
S: 247 kbytes, 34/10 files altered, 17 new
X: Summary patch (82k)

Kernel Config
A: Roman Zippel
M: http://lists.insecure.org/lists/linux-kernel/2002/Oct/6898.html
D: http://www.xs4all.nl/%7Ezippel/lc/lkc-1.2-2.5.44.diff.bz2
S: 2164 kbytes, 0/3 files altered, 178 new
X: Summary patch (7k)

Crypto API
A: James Morris
S: 141 kbytes, 21/6 files altered, 14 new
N: In Dave Miller's tree for IPSec support.

POSIX High Resolution Timers
A: George Anzinger
M: http://old.lwn.net/2002/0103/a/hrt.php3
D: http://unc.dl.sourceforge.net/sourceforge/high-res-timers/hrtimers-posix-2.5.44-1.0.patch
S: 66 kbytes, 18/2 files altered, 4 new
X: Summary patch (21k)

Crash Dumping (LKCD)
A: Matt Robinson, LKCD team
M: http://lists.insecure.org/lists/linux-kernel/2002/Oct/7060.html
D: http://lkcd.sourceforge.net/download/4.2pre/kernel/
S: 127 kbytes, 16/10 files altered, 9 new
X: Summary patch (17k)

Hotplug CPU Removal Support
A: Rusty Russell
D: http://www.kernel.org/pub/linux/kernel/people/rusty/patches/Hotcpu/hotcpu-cpudown.patch.gz
S: 32 kbytes, 16/0 files altered, 0 new
X: Summary patch (29k)

ucLinux Patch (MMU-less support)
A: Greg Ungerer
M: http://lwn.net/Articles/11016/
D: http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.44uc3.patch.gz
S: 2218 kbytes, 6/53 files altered, 429 new
X: Summary patch (40k)

initramfs
A: Al Viro
M: http://www.cs.helsinki.fi/linux/linux-kernel/2001-30/0110.html
D: ftp://ftp.math.psu.edu/pub/viro/N0-initramfs-C21
S: 16 kbytes, 5/1 files altered, 2 new
X: Summary patch (5k)

EVMS
A: EVMS Team
M: http://www.uwsg.iu.edu/hypermail/linux/kernel/0208.0/0109.html
S: 1146 kbytes, 4/12 files altered, 42 new
N: No convenient URL for patch.

Kernel Probes
A: Vamsi Krishna S
M: lists.insecure.org/linux-kernel/2002/Aug/1299.html
D: http://www.kernel.org/pub/linux/kernel/people/rusty/patches/Misc/kprobes.patch.gz
S: 17 kbytes, 3/4 files altered, 4 new
X: Summary patch (4k)

Device Mapper (LVM2)
A: LVM2 Team
M: http://www.sistina.com/products_lvm.htm
N: In -ac kernels, can't find convenient URL 8(
