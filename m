Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261451AbTCEBED>; Tue, 4 Mar 2003 20:04:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266865AbTCEBED>; Tue, 4 Mar 2003 20:04:03 -0500
Received: from air-2.osdl.org ([65.172.181.6]:51362 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261451AbTCEBD7>;
	Tue, 4 Mar 2003 20:03:59 -0500
Subject: Re: 2.5.63-osdl3
From: Stephen Hemminger <shemminger@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1046821955.30192.405.camel@dell_ss3.pdx.osdl.net>
References: <1046821955.30192.405.camel@dell_ss3.pdx.osdl.net>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1046826868.28069.5.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 04 Mar 2003 17:14:29 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch diff had some extra cruft should be fixed now.
2.5.63-osdl3a is available at  http://sourceforge.net/projects/osdldclor
or OSDL Patch Lifecycle Manager (http://www.osdl.org/cgi-bin/plm/)
	osdl-2.5.63-4	PLM # 1654

On Tue, 2003-03-04 at 15:52, Stephen Hemminger wrote:
> 2.5.63-osdl3 is available at  http://sourceforge.net/projects/osdldcl
> or BitKeeper          bk://bk.osdl.org/linux-2.5-osdl  TAG: v2.5.63-osdl3
> or OSDL Patch Lifecycle Manager (http://www.osdl.org/cgi-bin/plm/)
> 	osdl-2.5.63-3	PLM # 1625
> 
> 2.5.63-osdl3:
> o Align with latest LKCD
> o Update to latest AS scheduler from 2.5.63-mm2
> o Make defconfig turn on LTT,LKCD       (me)
>   This is to force config options on for STP
> 
> 2.5.63-osdl2:
> o Make default IO scheduler be deadline (me)
> o Improved flock bugfix		 	(Matthew Wilcox)
> 
> 2.5.63-osdl1:
> o Update to Megaraid 2 driver		(Matt Domsch, Mark Haverkamp)
> o Cpu Hot Plug				(Zwane Mwaikambo)
> o CFQ disk scheduler			(Jens Axboe)
> o Anticipatory scheduler		(Nick Piggin)
> o Pentium Performance Counters		(Mikael Pettersson)
> o Linux Kernel Crash Dump (LKCD)        (Matt Robinson, LKCD team)
> o Kernel Exec (Kexec)			(Eric W. Biederman)
> o Linux Trace Toolkit (LTT)             (Karim Yaghmour)
> o Kernel Config (ikconfig)		(Randy Dunlap)
> o Improved boot time TSC synchronization (Jim Houston)
> o RCU statistics               		(Dipankar Sarma)
> o Scheduler tunables            	(Robert Love)
> 
> Changes since 2.5.62
> * Merge -osdl and -dcl into one tree
>   Seperate trees were temporary till NUMA and hi-res timers
>   got merged to the base kernel.
> 
> + Update to LKCD 
>   Now includes latest memory and kexec hook.
> 
> + Add CFQ and AS scheduler from -mm tree
>   Can choose scheduler via the kernel boot commandline:
>         elevator=as 
>         elevator=cfq
>         elevator=deadline (default)
>   The anticipatory scheduler is experimental and may not boot
>   on some systems.
> 
> - Take out kprobe
>   No test available or interface available other than the
>   simple /dev/noisy
> 
> 
> Project information:
>         http://www.osdl.org/projects/dcl/
> 
> 
-- 
Stephen Hemminger <shemminger@osdl.org>
Open Source Devlopment Lab

