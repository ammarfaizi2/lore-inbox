Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266928AbSLWRex>; Mon, 23 Dec 2002 12:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266932AbSLWRex>; Mon, 23 Dec 2002 12:34:53 -0500
Received: from air-2.osdl.org ([65.172.181.6]:18865 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S266928AbSLWRew>;
	Mon, 23 Dec 2002 12:34:52 -0500
Date: Mon, 23 Dec 2002 09:41:31 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: <linux-kernel@vger.kernel.org>
Subject: [announce] linux-2.5.52-cgl
Message-ID: <Pine.LNX.4.33L2.0212230938060.20684-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This is an update to the OSDL CGL/DCL development conduit.  It is in
two pieces:  a common subset for CGL and DCL, and a separate patch for
CGL-only stuff.  The generic patches are for enhancements that are yet
to make the mainline kernel but are requested by both Carrier Grade
Linux (CGL) and Data Center Linux (DCL).

The CGL-specific patch applies after the first one (OSDL patch) and has
enhancements that are applicable mostly to carrier-grade
(telecommunications) systems.

The latest release is available as downloadable patches from
        http://sourceforge.net/projects/cglinux

or public BitKeeper repositories
        Common code:            bk://bk.osdl.org/linux-2.5-osdl
        Common code + CGL:      bk://bk.osdl.org/linux-2.5-cgl
        Common code + DCL:      bk://bk.osdl.org/linux-2.5-dcl

Note:  Module loading has changed in the latest versions of 2.5 and a
new version of module utilities is required.  Available at:
	http://www.kernel.org/pub/linux/kernel/people/rusty/modules/

OSDL CGL+DCL common:	patch-2-5.52-osdl1	[PLM patch # 1078]
* linux-2.5.52-osdl1
. More updates to LKCD			(Steve Hemminger)
. Update kprobes to use notifiers	(Steve Hemminger)
. Megaraid 2 SCSI driver		(Matt Domsch, Atul Mukker)

CGL-specific:  		patch-2-5.52-cgl1	[PLM patch # 1079]
* applies to -osdl1
. POSIX clocks & timers interface	(George Anzinger; 2002-12-20)
. high-res-timers			(George Anzinger; 2002-12-20)

Previous releases
-----------------
* linux-2.5.51-osdl1
. Update to LKCD kernel hooks           (Steve Hemminger)

* linux-2.5.47-osdl2
. More fixes to the megaraid driver     (Matt Domsch, Mark Haverkamp)
. Fix to LKCD block device setup        (Steve Hemminger)
. Default ACPI to off for SMP systems   (Steve Hemminger)
. Fix I/O errors on loop driver         (Hugh Dickins)

* linux-2.5.47-osdl1
. Linux Trace Toolkit (LTT)		(Karim Yaghmour)
. Linux Kernel Crash Dumps		(Matt Robinson, LKCD team)
.   Network crash dumps			(Mohammed Abbas)
. Kprobes				(Rusty Russell)
. Kernel Config storage			(Khalid Aziz, Randy Dunlap)
. DAC960 driver fixes			(Dave Olien)

CGL-specific:  patch-2.5.47-cgl1
. High-resolution timers		(George Anzinger; 2002-12-08)

Getting Involved
----------------
If interested in development of CGL, please subscribe to the mailing
list at http://lists.osdl.org/mailman/listinfo/cgl_discussion .

The kernel compiles and runs on an SMP system.  It passes the basic
tests but has not been extensively stress-tested yet.

This kernel has been built and run on a small set of OSDL STP machines,
both SMP and UP.  Testers are encouraged to exercise the features.  If a
problem is found, please compare the result with a standard 2.5.52
kernel.  Please report any problems or successes to the mailing list.

Users of this CGL tree are encouraged to send feedback or bug fix
patches.  Patches should be tested by using the OSDL Scalable Test
Platform (STP) and Patch Lifecycle Manager (PLM) facilities.

Project information:
CGL:
	http://www.osdl.org/projects/cgl/
	http://cglinux.sourceforge.net/
	http://sourceforge.net/projects/cglinux/
DCL:
	http://www.osdl.org/projects/dcl/
	http://osdldcl.sourceforge.net
	http://sourceforge.net/projects/osdldcl/
PLM:
	http://www.osdl.org/cgi-bin/plm/
STP:
	http://www.osdl.org/stp/
Developer pages:
	http://developer.osdl.org

###

-- 
~Randy


