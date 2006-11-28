Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936090AbWK1UIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936090AbWK1UIL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 15:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936092AbWK1UIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 15:08:10 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:27541 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S936090AbWK1UIJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 15:08:09 -0500
Date: Tue, 28 Nov 2006 21:06:11 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: "Linux-Kernel," <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19-rc6-rt7: Kernel BUG at kernel/rtmutex.c:672
Message-ID: <20061128200611.GB25364@elte.hu>
References: <1164737474.15887.10.camel@cmn3.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1164737474.15887.10.camel@cmn3.stanford.edu>
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

> (a normal non-root user was left logged in and was running jackd with 
> realtime privileges, irqs' priority reordered with the rtirq script - 
> I was getting, and still are under -rt8, lots of audio xruns but 
> that's for another thread).

do you get those xruns even with maxcpus=1? I.e. is it an SMP-only 
regression - or is UP affected too? [if it's UP then it would be simpler 
to trace that xrun]

	Ingo
