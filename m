Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935407AbWK2H1B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935407AbWK2H1B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 02:27:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935412AbWK2H1B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 02:27:01 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:63451 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S935407AbWK2H1A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 02:27:00 -0500
Date: Wed, 29 Nov 2006 08:24:50 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: "Linux-Kernel," <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19-rc6-rt8: alsa xruns
Message-ID: <20061129072450.GC1983@elte.hu>
References: <1164743931.15887.34.camel@cmn3.stanford.edu> <20061128200927.GA26934@elte.hu> <1164746224.15887.40.camel@cmn3.stanford.edu> <1164747854.15887.48.camel@cmn3.stanford.edu> <1164749755.15887.54.camel@cmn3.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1164749755.15887.54.camel@cmn3.stanford.edu>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	1.4 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:

> > I'll turn off the machine and cold boot it...)
> 
> No difference, actually it looks like the regression re-regresses if I 
> enable the trace... Arghhh.

yeah, that happens sometimes if some race is particularly narrow :-/

> Toggling /proc/sys/kernel/trace_enabled makes the long xruns reported 
> by jack come and go.

i'll try to reproduce it. Can you see it with my yum kernel too? (that 
would simplify checking this on many testboxes)

	Ingo
