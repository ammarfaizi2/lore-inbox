Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030233AbVI1JiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030233AbVI1JiA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 05:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030235AbVI1JiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 05:38:00 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:10689 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030233AbVI1Jh7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 05:37:59 -0400
Date: Wed, 28 Sep 2005 11:38:46 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: jack, PREEMPT_DESKTOP, delayed interrupts?
Message-ID: <20050928093846.GA30962@elte.hu>
References: <200509262108.55448.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509262108.55448.annabellesgarden@yahoo.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Karsten Wiese <annabellesgarden@yahoo.de> wrote:

> >  latency: 10852 us, #70/70, CPU#0 | (M:preempt VP:0, KP:1, SP:1 HP:1

> > softirq--8     0Dnh4 9901us : trace_change_sched_cpu (1 0 0)
> 
> Maybe your ethernet device is getting in the way.
> Do you also get jack dropouts with ethernet chip disabled,
> it's Module unloaded?

also, the M:preempt suggests that it's not a PREEMPT_RT kernel but a 
PREEMPT_DESKTOP kernel. Do the dropouts happen even with a PREEMPT_RT 
kernel?

	Ingo
