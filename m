Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267183AbSKPA4m>; Fri, 15 Nov 2002 19:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267184AbSKPA4m>; Fri, 15 Nov 2002 19:56:42 -0500
Received: from air-2.osdl.org ([65.172.181.6]:31453 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267183AbSKPA4k>;
	Fri, 15 Nov 2002 19:56:40 -0500
Date: Fri, 15 Nov 2002 17:02:52 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: <linux-kernel@vger.kernel.org>
Subject: [announce] 2.5.47-cgl1 patchset
Message-ID: <Pine.LNX.4.33L2.0211151702190.6746-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is an early release version that enables common CGL and DCL
development.  It is in two pieces:  a common subset for CGL and DCL,
and a separate patch for CGL-only stuff.  The generic patches are for
enhancements that are yet to make the mainline kernel but are requested
by both Carrier Grade Linux (CGL) and Data Center Linux (DCL).
The CGL-only patch applies after the first one (OSDL patch) and has
enhancements that are applicable mostly to carrier-grade
(telecommunications) systems.

The latest release is available in downloadable patches from
	http://sourceforge.net/projects/cglinux

or public BitKeeper repositories
	Common code:		bk://bk.osdl.org/linux-2.5-osdl
	Common code + CGL:	bk://bk.osdl.org/linux-2.5-cgl
	Common code + DCL:	bk://bk.osdl.org/linux-2.5-dcl

The kernel compiles and runs on an SMP system.  It passes the basic
tests but has not been extensively stress-tested yet.


OSDL CGL+DCL common enhancements:  linux-2547-osdl2.diff.bz2
. More fixes to the megaraid driver	(Matt Domsch, Mark Haverkamp)
. Fix to LKCD block device setup	(me)
. Default ACPI to off for SMP systems	(me)
. Fix I/O errors on loop driver		(Hugh Dickins)

* in linux-2.5.47-osdl1
. Linux Trace Toolkit (LTT)          (Karim Yaghmour)
. Linux Kernel Crash Dumps           (Matt Robinson, LKCD team)
.   Network crash dumps              (Mohammed Abbas)
. Kprobes			     (Rusty Russell)
. Kernel Config storage              (Khalid Aziz, Randy Dunlap)
. DAC960 driver fixes                (Dave Olien)

CGL-specific:  linux-2547-cgl1.diff.bz2
. High-resolution timers              (George Anzinger)


Getting Involved
----------------
If interested in development of CGL, please subscribe to the mailing
list at http://lists.osdl.org/mailman/listinfo/cgl_discussion .

This kernel has been built and run on a small set of machines, SMP
and UP.  Testers are encouraged to exercise the features.  If a
problem is found, please compare the result with a standard 2.5.47
kernel.  Please report any problems or successes to the mailing list.

Developers are encouraged to send any enhancements or bug fix
patches.  Patches should be tested by using the OSDL Scalable Test
Platform (STP) and Patch Lifecycle Manager (PLM) facilities.

Project information:
	http://www.osdl.org/projects/cgl/
	http://cglinux.sourceforge.net/
	http://sourceforge.net/projects/cglinux/
DCL:
	http://www.osdl.org/projects/dcl/
	http://osdldcl.sourceforge.net
	http://sourceforge.net/projects/osdldcl/

###

-- 
~Randy

