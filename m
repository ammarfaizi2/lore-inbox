Return-Path: <linux-kernel-owner+w=401wt.eu-S1752837AbWLOQWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752837AbWLOQWu (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 11:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752828AbWLOQWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 11:22:39 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:54637 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752830AbWLOQWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 11:22:20 -0500
Date: Fri, 15 Dec 2006 17:19:52 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: v2.6.19-rt6, yum/rpm
Message-ID: <20061215161952.GA29191@elte.hu>
References: <20061205171114.GA25926@elte.hu> <4582CAD6.9040404@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4582CAD6.9040404@ru.mvista.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> >as usual, bugreports, fixes and suggestions are welcome,
> 
>    Be aware that even with the newest -rt patch, the PowerPC TOD 
> vsyscalls are still broken, i.e. glibc may return imprecise/incorrect 
> results for the related calls -- despite arch/powerpc/kernel/time.c 
> has been at last fixed to at least compile, the PowerPC clocksource 
> patch removed the important part of TOD vsyscall support, and this 
> hasn't been dealt with.  I've sent to Thomas Gleixner a patch removing 
> the affected vsyscalls altogether for the time being in the early 
> November (unfortunately, I came to know of the breakage too late, and 
> hadn't time to deal with it propery due to othr woes), however, I'm 
> not seeing any of my patches (I've also done PowerPC clockevents 
> support) merged to -rt (or otherwise published). Most of the patches 
> can be found in the linuxppc-dev list archives, for the interested...

could you resend them to me please?

	Ingo
