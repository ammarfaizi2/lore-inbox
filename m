Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbVKZTFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbVKZTFX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 14:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbVKZTFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 14:05:23 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:48868 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750718AbVKZTFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 14:05:22 -0500
Subject: Re: 2.6.14-rt15: cannot build with !PREEMPT_RT
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       david singleton <dsingleton@mvista.com>
In-Reply-To: <20051126122332.GA3712@elte.hu>
References: <1132987928.4896.1.camel@mindpipe>
	 <20051126122332.GA3712@elte.hu>
Content-Type: text/plain
Date: Sat, 26 Nov 2005 14:05:12 -0500
Message-Id: <1133031912.5904.12.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-11-26 at 13:23 +0100, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > I get tons of these errors:
> > 
> >   CC      arch/i386/kernel/i386_ksyms.o
> > In file included from include/linux/spinlock.h:97,
> >                  from include/linux/capability.h:45,
> >                  from include/linux/sched.h:7,
> >                  from include/linux/module.h:10,
> >                  from arch/i386/kernel/i386_ksyms.c:2:
> > include/linux/rt_lock.h:386: warning: 'struct semaphore' declared inside
> > parameter list
> > include/linux/rt_lock.h:386: warning: its scope is only this definition
> > or declaration, which is probably not what you want
> 
> could you try -rt16, does it work better?
> 

-rt19 seems to work except that asm/io_apic.h fails to include 
asm/apicdef.h so MAX_IO_APICS is undefined.

Lee

