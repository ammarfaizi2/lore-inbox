Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316746AbSGZDa7>; Thu, 25 Jul 2002 23:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316747AbSGZDa7>; Thu, 25 Jul 2002 23:30:59 -0400
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:44029 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S316746AbSGZDa7>;
	Thu, 25 Jul 2002 23:30:59 -0400
Date: Thu, 25 Jul 2002 23:34:10 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.28: "bad: schedule() with irqs disabled!"
Message-ID: <20020726033410.GA3354@www.kroptech.com>
References: <20020726031914.GA32749@www.kroptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020726031914.GA32749@www.kroptech.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

...and another one appearing at the end of the boot process...

--Adam

ksymoops 2.4.1 on i686 2.5.28.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.28/ (default)
     -m /boot/System.map-2.5.28 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Warning (compare_maps): ksyms_base symbol GPLONLY___wake_up_sync not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_idle_cpu not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_set_cpus_allowed not found in System.map.  Ignoring ksyms_base entry
c8cc5f44 c0285c20 c8da2ce0 c8cc5f70 c01146bf c8da2ce0 c0315e40 c0315e40 
       c8cc4000 00000000 c8cc5fc4 c8da2ce0 c01186a7 00000000 c90818c0 00000000 
       c8e31c60 c013e7d9 c90818c0 c8e31c60 c90818c0 c8e31c60 c8cc4000 00000000 
Call Trace: [<c01146bf>] [<c01186a7>] [<c013e7d9>] [<c0105b45>] [<c010717f>] 
Warning (Oops_read): Code line not seen, dumping what data is available

Trace; c01146bf <wake_up_forked_process+17f/190>
Trace; c01186a7 <do_fork+727/8c0>
Trace; c013e7d9 <filp_close+a9/c0>
Trace; c0105b45 <sys_fork+15/30>
Trace; c010717f <syscall_call+7/b>


6 warnings issued.  Results may not be reliable.

