Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265361AbSKLAiK>; Mon, 11 Nov 2002 19:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265385AbSKLAiK>; Mon, 11 Nov 2002 19:38:10 -0500
Received: from air-2.osdl.org ([65.172.181.6]:28317 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265361AbSKLAiJ>;
	Mon, 11 Nov 2002 19:38:09 -0500
Subject: [ANNOUNCE] linux-2.5.47-dcl1
From: Stephen Hemminger <shemminger@osdl.org>
To: Kernel List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 11 Nov 2002 16:44:57 -0800
Message-Id: <1037061897.12335.43.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an early release version that enables common CGL and DCL
development. It is in two pieces: a common subset of CGL and DCL; and a
separate patch for DCL only stuff. The generic patches are for
enhancements that are yet to make the main kernel stream but are
requested by both Carrier Grade Linux (CGL) and Data Center (DCL). The
second patch applies after the first one and has enhancements that are
applicable mostly to large data center systems.

The latest release is available patches on 
	http://sourceforge.net/projects/osdldcl
or public BitKeeper repositories
	Common code: bk://bk.osdl.org/linux-2.5-osdl 
	DCL + common code: bk://bk.osdl.org/linux-2.5.-dcl

The kernel compiles and runs on SMP and UP systems; it passes the basic
tests but has not been extensively stress tested yet.  The crash dump
and trace code has not been validated yet. NUMA testing has not been
done yet.

CGL+DCL common enhancements: linux-2.5.47-osdl.diff.bz2
 * Linux Trace Toolkit (LTT)          (Karim Yaghmour)

 * Linux Kernel Crash Dumps           (Matt Robinson, LKCD team)
 *   Network crash dumps	      (Mohammed Abbas)

 * Kernel Config storage              (Khalid Aziz, Randy Dunlap)

 * DAC960 driver fixes                (Dave Olien)

DCL specific: dcl-2.5.47.diff.bz2
  
* NUMA scheduler enhancements         (Erich Focht, Michael Hohnbaum)


Getting Involved
----------------
If interested in development of DCL, please subscribe to dcl_discussion
mailing list at http://lists.osdl.org/mailman/listinfo

This kernel has been built and run on a small set of machines, SMP
and UP. Testers are encouraged to exercise the features especially on
large SMP and NUMA architectures.  If a problem is found, please
compare the result with a standard 2.5.46 kernel.  Please report any
problems or successes to the mailing list.

Developers are encouraged to send any enhancements or bug fixes
patches. Patches should be tested by using the OSDL Scalable Test
Platform (STP) and Patch Lifecycle Manager (PLM) facilities.









