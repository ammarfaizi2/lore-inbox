Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261329AbVCaL0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbVCaL0e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 06:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbVCaL0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 06:26:34 -0500
Received: from mx1.elte.hu ([157.181.1.137]:6579 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261329AbVCaL0b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 06:26:31 -0500
Date: Thu, 31 Mar 2005 13:26:02 +0200
From: Ingo Molnar <mingo@elte.hu>
To: kus Kusche Klaus <kus@keba.com>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-25
Message-ID: <20050331112602.GA27286@elte.hu>
References: <AAD6DA242BC63C488511C611BD51F3673231CD@MAILIT.keba.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AAD6DA242BC63C488511C611BD51F3673231CD@MAILIT.keba.co.at>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* kus Kusche Klaus <kus@keba.com> wrote:

> > i have released the -V0.7.41-25 Real-Time Preemption patch, 
> > which can be 
> > downloaded from the usual place:
> 
> 1. Does not compile without RT_DEADLOCK_DETECT:
> kernel/rt.c: In function `change_owner':
> kernel/rt.c:556: error: structure has no member named `debug'

ok - i fixed this in -42-01.

> 2. My problem (see my LKML mails yesterday) is not yet solved: The 
> latency tracer shows latencies of at most 40 microseconds, but my test 
> program at rtprio 99 sometimes did not get any CPU for milliseconds...

(please Cc: me on PREEMPT_RT related mails - i might not notice lkml 
mails.) I'll reply to your lkml mail in a separate thread.

	Ingo
