Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265402AbSLJTU2>; Tue, 10 Dec 2002 14:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265543AbSLJTU2>; Tue, 10 Dec 2002 14:20:28 -0500
Received: from air-2.osdl.org ([65.172.181.6]:64687 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265402AbSLJTU1>;
	Tue, 10 Dec 2002 14:20:27 -0500
Subject: [announce] linux-2.5.51-dcl1
From: Stephen Hemminger <shemminger@osdl.org>
To: Kernel List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1039548491.1054.178.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 10 Dec 2002 11:28:11 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an early release version that enables common CGL and DCL
development.  It is in two pieces:  a common subset for CGL and DCL,
and a separate patch for DCL-only stuff.  The generic patches are for
enhancements that are yet to make the mainline kernel but are requested
by both Carrier Grade Linux (CGL) and Data Center Linux (DCL).
The DCL-only patch applies after the first one (OSDL patch) and has
enhancements that are applicable mostly to NUMA systems used in 
data center systems.

The latest release is available in downloadable patches from
        http://sourceforge.net/projects/osdldcl

or public BitKeeper repositories
        Common code:            bk://bk.osdl.org/linux-2.5-osdl
        Common code + CGL:      bk://bk.osdl.org/linux-2.5-cgl
        Common code + DCL:      bk://bk.osdl.org/linux-2.5-dcl

The kernel compiles and runs on an SMP system.  It passes the basic
tests but has not been extensively stress-tested yet.

Note: module loading has changed in latest versions of 2.5 and
a new version of module utilities is required.  Available at:
	http://www.kernel.org/pub/linux/kernel/people/rusty/modules/

OSDL CGL+DCL common enhancements:   patch-2.5.51-osdl1
* linux-2.5.51-osdl1
. Update to LKCD kernel hooks           (me)

* linux-2.5.47-osdl2
. More fixes to the megaraid driver     (Matt Domsch, Mark Haverkamp)
. Fix to LKCD block device setup        (me)
. Default ACPI to off for SMP systems   (me)
. Fix I/O errors on loop driver         (Hugh Dickins)

* linux-2.5.47-osdl1
. Linux Trace Toolkit (LTT)          (Karim Yaghmour)
. Linux Kernel Crash Dumps           (Matt Robinson, LKCD team)
.   Network crash dumps              (Mohammed Abbas)
. Kprobes                            (Rusty Russell)
. Kernel Config storage              (Khalid Aziz, Randy Dunlap)
. DAC960 driver fixes                (Dave Olien)

DCL-specific:  patch-2.5.51-osdl1-dcl1
. NUMA scheduler		     (Eric Focht, Michael Hohnbaum)


Getting Involved
----------------
If interested in development of DCL, please subscribe to the mailing
list at http://lists.osdl.org/mailman/listinfo/dcl_discussion .

This kernel has been built and run on a small set of machines, SMP
and UP.  Testers are encouraged to exercise the features.  If a
problem is found, please compare the result with a standard 2.5.51
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
        http://sourceforge.net/projects/osdldcl



