Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030352AbWGZIRW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030352AbWGZIRW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 04:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932520AbWGZIRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 04:17:22 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:6016 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932522AbWGZIRV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 04:17:21 -0400
Date: Wed, 26 Jul 2006 10:07:39 +0200
From: Ingo Molnar <mingo@elte.hu>
To: andrea@cpushare.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       "bruce@andrew.cmu.edu" <bruce@andrew.cmu.edu>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>, Adrian Bunk <bunk@stusta.de>,
       Lee Revell <rlrevell@joe-job.com>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] TIF_NOTSC and SECCOMP prctl
Message-ID: <20060726080739.GA10574@elte.hu>
References: <200607180623_MC3-1-C54F-3802@compuserve.com> <20060718132941.GG5726@opteron.random> <20060725214441.GC32243@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060725214441.GC32243@opteron.random>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.3
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.3 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* andrea@cpushare.com <andrea@cpushare.com> wrote:

> Here a repost of the last seccomp patch against current mainline 
> including the preempt fix. This changes the seccomp API from 
> /proc/<pid>/seccomp to a prctl (this will produce a smaller kernel) 
> and it adds a TIF_NOTSC that seccomp sets. Only the current task can 
> call disable_TSC (obviously because it hasn't a task_t param). This 
> includes Chuck's patch to give zero runtime cost to the notsc feature.

please send a patch-queue that is properly split-up: the bugfix, the API 
change and the TIF_NOTSC improvement.

	Ingo
