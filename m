Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268617AbTBYWwc>; Tue, 25 Feb 2003 17:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268618AbTBYWwc>; Tue, 25 Feb 2003 17:52:32 -0500
Received: from air-2.osdl.org ([65.172.181.6]:32405 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S268617AbTBYWwa>;
	Tue, 25 Feb 2003 17:52:30 -0500
Subject: 2.5.63-osdl2
From: Stephen Hemminger <shemminger@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1046214166.18513.22.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 25 Feb 2003 15:02:46 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The 2.5.63-osdl2 is available at 
	http://sourceforge.net/projects/osdldcl
or BitKeeper          
	bk://bk.osdl.org/linux-2.5-osdl
or OSDL Patch Lifecycle Manager (http://www.osdl.org/cgi-bin/plm/)
	osdl-2.5.63-2	PLM # 1621

2.5.63-osdl2:
o Make default IO scheduler be deadline (me)
o Improved flock bugfix		 	(Matthew Wilcox)

2.5.63-osdl1:
o Update to Megaraid 2 driver		(Matt Domsch, Mark Haverkamp)
o Cpu Hot Plug				(Zwane Mwaikambo)
o CFQ disk scheduler			(Jens Axboe)
o Anticipatory scheduler		(Nick Piggin)
o Pentium Performance Counters		(Mikael Pettersson)
o Linux Kernel Crash Dump (LKCD)        (Matt Robinson, LKCD team)
o Kernel Exec (Kexec)			(Eric W. Biederman)
o Linux Trace Toolkit (LTT)             (Karim Yaghmour)
o Kernel Config (ikconfig)		(Randy Dunlap)
o Improved boot time TSC synchronization (Jim Houston)
o RCU statistics               		(Dipankar Sarma)
o Scheduler tunables            	(Robert Love)

Changes since 2.5.62
* Merge -osdl and -dcl into one tree
  Seperate trees were temporary till NUMA and hi-res timers
  got merged to the base kernel.

+ Update to LKCD 
  Now includes latest memory and kexec hook.

+ Add CFQ and AS scheduler from -mm tree
  Can choose scheduler via the kernel boot commandline:
        elevator=as 
        elevator=cfq
        elevator=deadline (default)
  The anticipatory scheduler is experimental and may not boot
  on some systems.

- Take out kprobe
  No test available or interface available other than the
  simple /dev/noisy


Project information:
        http://www.osdl.org/projects/dcl/





