Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317263AbSGOAlH>; Sun, 14 Jul 2002 20:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317267AbSGOAlG>; Sun, 14 Jul 2002 20:41:06 -0400
Received: from tomts17-srv.bellnexxia.net ([209.226.175.71]:36847 "EHLO
	tomts17-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S317263AbSGOAlF>; Sun, 14 Jul 2002 20:41:05 -0400
From: Ed Tomlinson <tomlins@cam.org>
Subject: Re: [PATCH] preemptive kernel for 2.4.19-rc1-ac3
To: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
Reply-To: tomlins@cam.org
Date: Sun, 14 Jul 2002 20:43:54 -0400
References: <1026681042.939.9.camel@sinai>
Organization: me
User-Agent: KNode/0.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20020715004355.65B462D12A@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you build with preempt=N (for the scheduler stuff) the link of the 
kernel fails.  

kernel/kernel.o: In function `sys_sched_yield':
kernel/kernel.o(.text+0x1154): undefined reference to 
`spin_unlock_no_resched'

Ed Tomlinson

make: *** [vmlinux] Error 1


Robert Love wrote:

> A preempt-kernel patch for 2.4.19-rc1-ac3 is available at:
> 
> 
ftp://ftp.kernel.org/pub/linux/kernel/people/rml/preempt-kernel/v2.4/preempt-kernel-rml-2.4.19-rc1-ac3-1.patch
> 
> and mirrors.
> 
> The recent scheduler bits introduced plenty of changes to cause the
> patch to fail to apply.
> 
> This new preempt-kernel patch also includes some of the
> scheduler-related preemption optimizations found in 2.5.
> 
> Robert Love
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

