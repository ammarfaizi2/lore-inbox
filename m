Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261600AbTA1WmV>; Tue, 28 Jan 2003 17:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261615AbTA1WmV>; Tue, 28 Jan 2003 17:42:21 -0500
Received: from air-2.osdl.org ([65.172.181.6]:26328 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261600AbTA1WmS>;
	Tue, 28 Jan 2003 17:42:18 -0500
Subject: 2.5.59-dcl2
From: Stephen Hemminger <shemminger@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1043794298.10153.241.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 28 Jan 2003 14:51:38 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update to the OSDL DCL patch set. 

The OSDL common includes RAS related enhancements, bugfixes, and 
latest version of drivers for the OSDL server test machines.
   Linux Trace Toolkit (LTT)            (Karim Yaghmour)
   Linux Kernel Crash Dump (LKCD)       (Matt Robinson, LKCD team)
   Kernel Probes (kprobes)              (Rusty Russell)
   Megaraid 2 driver                    (Matt Domsch)
   DAC960 driver                        (Dave Olien)
        
The goal is to make these projects more robust and resolve potential
overlaps. Also this set keeps up to date with the latest version of
drivers for the disk devices that are present on the OSDL test
machines.

The DCL-only patch contains performance and tuning related
enhancements.  The goal is to use these for database performance
tuning and give these projects more testing.

2.5.59-osdl2:
. Dac960 error retry                    (Dave Olien)

2.5.59-dcl2:
. Lost timer tick compensation          (John Stultz)
. Improved boot time TSC synchronization (Jim Houston)
. Lockless gettimeofday                 (Andi Kleen, me)
. Performance monitoring counters for x86 (Mikael Pettersson)

2.5.59-osdl1:
. Bug fix for vmlinux.ld.S		(Kai Germaschewski)
. Update to LKCD for multiple schemes   (Bharata B Rao)
. Bug fixes for LKCD locking            (me)
. Improved i386 fatal event notifiers   (me)
. Kprobe using notify_die               (me)

2.5.59-dcl1:
.  RCU statistics                   (Dipankar Sarma)
.  Scheduler tunables               (Robert Love)

The latest release is available in downloadable patches from
        http://sourceforge.net/projects/osdldcl

or public BitKeeper repositories
        Common code:            bk://bk.osdl.org/linux-2.5-osdl
        Common code + CGL:      bk://bk.osdl.org/linux-2.5-cgl
        Common code + DCL:      bk://bk.osdl.org/linux-2.5-dcl

Getting Involved
----------------
If interested in development of DCL, please subscribe to the mailing
list at http://lists.osdl.org/mailman/listinfo/dcl_discussion.

Developers are encouraged to send any enhancements or bug fix
patches.  Patches should be tested by using the OSDL Scalable Test
Platform (STP) and Patch Lifecycle Manager (PLM) facilities.

Project information:
        http://www.osdl.org/projects/dcl/
        http://osdldcl.sourceforge.net
        http://sourceforge.net/projects/osdldcl





