Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269582AbUICDSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269582AbUICDSV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 23:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269056AbUICDSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 23:18:18 -0400
Received: from tomts10.bellnexxia.net ([209.226.175.54]:50327 "EHLO
	tomts10-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S269581AbUICDRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 23:17:33 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R0
From: Eric St-Laurent <ericstl34@sympatico.ca>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Mark_H_Johnson@raytheon.com,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>
In-Reply-To: <1094171082.19760.7.camel@krustophenia.net>
References: <OF04883085.9C3535D2-ON86256F00.0065652B@raytheon.com>
	 <20040902063335.GA17657@elte.hu> <20040902065549.GA18860@elte.hu>
	 <20040902111003.GA4256@elte.hu> <20040902215728.GA28571@elte.hu>
	 <1094162812.1347.54.camel@krustophenia.net>
	 <20040902221402.GA29434@elte.hu>
	 <1094171082.19760.7.camel@krustophenia.net>
Content-Type: text/plain
Message-Id: <1094181447.4815.6.camel@orbiter>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 02 Sep 2004 23:17:27 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Judging from these graphs, all of the latency issues are solved, at
> least on my UP hardware, and the latencies seem to be getting very close
> to the limits of what the hardware can do:
> 
> http://krustophenia.net/testresults.php?dataset=2.6.9-rc1-Q6#/var/www/2.6.9-rc1-Q6/jack-test-1
> 
> The worst case latency is only 160 usecs, and the vast majority fall
> into the pattern from 0 to 120 usecs.  All of the spikes above 120 are
> almost certainly caused by netdev_max_backlog.  However these are not
> long enough to cause any problems with my workload; the lowest practical
> latency for audio work is around 0.66 ms (32 frames at 48khz). 

Lee,

A few weeks ago you wrote that "the worst latency I was able to trigger
was 46 usecs", now it's 160 usecs.

Ingo has done much work on his patches since then.

Why the worst latency is higher now? I presume that the latency
measurements technique are more accurate and the 46 usecs was
inaccurate?

Ref: http://uwsg.indiana.edu/hypermail/linux/kernel/0407.3/0994.html

Best regards,

Eric St-Laurent


