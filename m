Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261436AbVBGOjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbVBGOjJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 09:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbVBGOfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 09:35:51 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:61083 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261432AbVBGOfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 09:35:19 -0500
Date: Mon, 7 Feb 2005 07:35:14 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
Message-ID: <20050207143513.GI7686@smtp.west.cox.net>
References: <20050204100347.GA13186@elte.hu> <20050204181958.GA6073@smtp.west.cox.net> <20050207090356.GA17372@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050207090356.GA17372@elte.hu>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2005 at 10:03:56AM +0100, Ingo Molnar wrote:
> 
> * Tom Rini <trini@kernel.crashing.org> wrote:
> 
> > On Fri, Feb 04, 2005 at 11:03:47AM +0100, Ingo Molnar wrote:
> > > 
> > > i have released the -V0.7.38-01 Real-Time Preemption patch, which can be
> > > downloaded from the usual place:
> > > 
> > >   http://redhat.com/~mingo/realtime-preempt/
> > 
> > I thought I saw you say x64 should be OK now a few releases ago, so:
> > linux-2.6.11-rc3/arch/x86_64/kernel/x8664_ksyms.c:197: error: `_atomic_dec_and_lock' undeclared here (not in a function)
> > linux-2.6.11-rc3/arch/x86_64/kernel/x8664_ksyms.c:197: error: initializer element is not constant
> > linux-2.6.11-rc3/arch/x86_64/kernel/x8664_ksyms.c:197: error: (near initialization for `__ksymtab__atomic_dec_and_lock.value')
> > linux-2.6.11-rc3/arch/x86_64/kernel/x8664_ksyms.c:197: error: __ksymtab__atomic_dec_and_lock causes a section type conflict
> > make[2]: *** [arch/x86_64/kernel/x8664_ksyms.o] Error 1
> > make[1]: *** [arch/x86_64/kernel] Error 2
> > make: *** [_all] Error 2
> 
> please send me your .config - mine builds/boots/works fine.

I don't have it handy anymore, but I just cp'd arch/x86_64/defconfig to
.config, ran oldconfig and turned RT off (PREEMPT_NONE=y) (oops, I did
forget to mention that, didn't I?  Sorry).

-- 
Tom Rini
http://gate.crashing.org/~trini/
