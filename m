Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267029AbTATVvv>; Mon, 20 Jan 2003 16:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267141AbTATVvu>; Mon, 20 Jan 2003 16:51:50 -0500
Received: from air-2.osdl.org ([65.172.181.6]:47073 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267029AbTATVvr>;
	Mon, 20 Jan 2003 16:51:47 -0500
Subject: 2.5.59-dcl1
From: Stephen Hemminger <shemminger@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1043100052.20836.18.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 20 Jan 2003 14:00:52 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.59 version of the OSDL common and DCL specific patches.

In addition to updating to the 2.5.59, the changes are housekeeping
to reduce the size of the patch.

New in this release: -osdl
+ Bug fix to make loading modules work with RH 8 (Kai Germaschewski)
- Remove C99 initializer notifier patch          (me)
- Remove partial sched_tune patch                (me)

New in this release: -dcl
- Remove Numa scheduler now a part of standard 2.5.59   

The generic patches are for enhancements that are yet to make the
mainline kernel but are requested by both Carrier Grade Linux (CGL)
and Data Center Linux (DCL). 

The latest release is available in downloadable patches from
        http://sourceforge.net/projects/osdldcl

or public BitKeeper repositories
        Common code:            bk://bk.osdl.org/linux-2.5-osdl
        Common code + CGL:      bk://bk.osdl.org/linux-2.5-cgl
        Common code + DCL:      bk://bk.osdl.org/linux-2.5-dcl

The OSDL common includes RAS related enhancements, bugfixes, and 
latest version of drivers for the OSDL server test machines.

   OProfile support for Pentium4	(John Levon, Graydon Hoare)
   Linux Trace Toolkit (LTT)	        (Karim Yaghmour)
   Linux Kernel Crash Dump (LKCD)	(Matt Robinson, LKCD team)
   Kernel Probes (kprobes)		(Rusty Russell)
   Megaraid 2 driver			(Matt Domsch)

The DCL-only patch applies after the first one (OSDL patch) and has
enhancements that are applicable mostly to NUMA systems used in 
data center systems.

  RCU statistics		   (Dipankar Sarma)
  Scheduler tunables		   (Robert Love)

The kernel compiles and runs on an UP and SMP system.  
The LTP, contest, and other benchmarks have been run using the OSDL
Scalable Test Platform.  LKCD has been tested for oops,
panic and NMI handling on SMP systems with preempt.
Kprobes has been exercised using the "noisy" test device.


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
        http://www.osdl.org/projects/dcl/
        http://osdldcl.sourceforge.net
        http://sourceforge.net/projects/osdldcl



