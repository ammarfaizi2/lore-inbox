Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbVKZMXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbVKZMXY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 07:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750854AbVKZMXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 07:23:23 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:56301 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750835AbVKZMXX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 07:23:23 -0500
Date: Sat, 26 Nov 2005 13:23:32 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       david singleton <dsingleton@mvista.com>
Subject: Re: 2.6.14-rt15: cannot build with !PREEMPT_RT
Message-ID: <20051126122332.GA3712@elte.hu>
References: <1132987928.4896.1.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132987928.4896.1.camel@mindpipe>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.4 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> I get tons of these errors:
> 
>   CC      arch/i386/kernel/i386_ksyms.o
> In file included from include/linux/spinlock.h:97,
>                  from include/linux/capability.h:45,
>                  from include/linux/sched.h:7,
>                  from include/linux/module.h:10,
>                  from arch/i386/kernel/i386_ksyms.c:2:
> include/linux/rt_lock.h:386: warning: 'struct semaphore' declared inside
> parameter list
> include/linux/rt_lock.h:386: warning: its scope is only this definition
> or declaration, which is probably not what you want

could you try -rt16, does it work better?

	Ingo
