Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263340AbUFRFwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263340AbUFRFwI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 01:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263415AbUFRFwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 01:52:08 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:33236 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263340AbUFRFwD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 01:52:03 -0400
Date: Thu, 17 Jun 2004 22:51:52 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: 4Front Technologies <dev@opensound.com>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Stop the Linux kernel madness
Message-ID: <601230000.1087537911@[10.10.2.4]>
In-Reply-To: <40D23701.1030302@opensound.com>
References: <40D232AD.4020708@opensound.com> <3217460000.1087518092@flay> <40D23701.1030302@opensound.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Our commercial OSS drivers work perfectly with Linux 2.6.5, 2.6.6, 2.6.7
> and they are failing to install with SuSE's 2.6.5 kernel. The reason is that
> they have gone and changed the kernel headers which mean that nothing works.
> 
> For instance our kernel interface module doesn't compile anymore we see the following
> errors:
> 
>> make -C /lib/modules/`uname -r`/build scripts scripts_basic include/linux/version.h
>> make[1]: Entering directory `/usr/src/linux-2.6.5-7.75-obj/i386/bigsmp'
>> make[1]: Nothing to be done for `scripts'.
>> make[1]: *** No rule to make target `scripts_basic'.  Stop.
>> make[1]: Leaving directory `/usr/src/linux-2.6.5-7.75-obj/i386/bigsmp'
>> make: *** [ossbuild] Error 2
>>  
>> Trying to compile using INCLUDE=/lib/modules/2.6.5-7.75-bigsmp/build/include
>> In file included from /usr/include/asm/smp.h:18,
>>                  from /usr/include/linux/smp.h:17,
>>                  from /usr/include/linux/sched.h:23,
>>                  from /usr/include/linux/module.h:10,
>>                  from src/sndshield.c:49:
>> /usr/include/asm/mpspec.h:6:25: mach_mpspec.h: No such file or directory
>> In file included from /usr/include/asm/smp.h:18,
>>                  from /usr/include/linux/smp.h:17,
>>                  from /usr/include/linux/sched.h:23,
>>                  from /usr/include/linux/module.h:10,
> 
> 
> 
> Why is this happening?. It's working fine with Linux 2.6.5 and also worked with
> Linux 2.6.4 kernels from SuSE 9.1

Are you seriously trying to tell me that you write drivers, and you
can't figure out a simple include file dependency problem?

M.

