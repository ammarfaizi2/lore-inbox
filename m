Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269255AbUICGgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269255AbUICGgq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 02:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269310AbUICGgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 02:36:46 -0400
Received: from mx2.elte.hu ([157.181.151.9]:32953 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269255AbUICGgU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 02:36:20 -0400
Date: Fri, 3 Sep 2004 08:36:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Eric St-Laurent <ericstl34@sympatico.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Mark_H_Johnson@raytheon.com,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R0
Message-ID: <20040903063658.GA11801@elte.hu>
References: <OF04883085.9C3535D2-ON86256F00.0065652B@raytheon.com> <20040902063335.GA17657@elte.hu> <20040902065549.GA18860@elte.hu> <20040902111003.GA4256@elte.hu> <20040902215728.GA28571@elte.hu> <1094162812.1347.54.camel@krustophenia.net> <20040902221402.GA29434@elte.hu> <1094171082.19760.7.camel@krustophenia.net> <1094181447.4815.6.camel@orbiter> <1094192788.19760.47.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094192788.19760.47.camel@krustophenia.net>
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


* Lee Revell <rlrevell@joe-job.com> wrote:

> -Q and later use the current method, which is like the above except
> the second hump is discarded, as it is a function of the scheduling
> latency and the period size rather than just the scheduling latency:
> 
> 	http://krustophenia.net/testresults.php?dataset=2.6.9-rc1-Q6
> 
> So, don't be fooled by the numbers, the newest version of the patch is
> in fact the best.  I have been meaning to go back and measure the
> current patches with the old code but it's pretty low priority...

vanilla kernel 2.6.8.1 would be quite interesting to get a few charts of
- especially if your measurement methodology has changed. There's not
much sense in re-testing older VP patches.

also, has the userspace workload you are using stayed constant during
all these tests?

	Ingo
