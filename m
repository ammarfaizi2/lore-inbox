Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261370AbVBGJEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261370AbVBGJEQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 04:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbVBGJEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 04:04:16 -0500
Received: from mx1.elte.hu ([157.181.1.137]:40377 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261370AbVBGJEI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 04:04:08 -0500
Date: Mon, 7 Feb 2005 10:03:56 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
Message-ID: <20050207090356.GA17372@elte.hu>
References: <20050204100347.GA13186@elte.hu> <20050204181958.GA6073@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050204181958.GA6073@smtp.west.cox.net>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Tom Rini <trini@kernel.crashing.org> wrote:

> On Fri, Feb 04, 2005 at 11:03:47AM +0100, Ingo Molnar wrote:
> > 
> > i have released the -V0.7.38-01 Real-Time Preemption patch, which can be
> > downloaded from the usual place:
> > 
> >   http://redhat.com/~mingo/realtime-preempt/
> 
> I thought I saw you say x64 should be OK now a few releases ago, so:
> linux-2.6.11-rc3/arch/x86_64/kernel/x8664_ksyms.c:197: error: `_atomic_dec_and_lock' undeclared here (not in a function)
> linux-2.6.11-rc3/arch/x86_64/kernel/x8664_ksyms.c:197: error: initializer element is not constant
> linux-2.6.11-rc3/arch/x86_64/kernel/x8664_ksyms.c:197: error: (near initialization for `__ksymtab__atomic_dec_and_lock.value')
> linux-2.6.11-rc3/arch/x86_64/kernel/x8664_ksyms.c:197: error: __ksymtab__atomic_dec_and_lock causes a section type conflict
> make[2]: *** [arch/x86_64/kernel/x8664_ksyms.o] Error 1
> make[1]: *** [arch/x86_64/kernel] Error 2
> make: *** [_all] Error 2

please send me your .config - mine builds/boots/works fine.

	Ingo
