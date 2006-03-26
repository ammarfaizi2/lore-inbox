Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbWCZXVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbWCZXVs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 18:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWCZXVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 18:21:48 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:3274 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932193AbWCZXVr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 18:21:47 -0500
Date: Mon, 27 Mar 2006 01:19:13 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rt21, BUG at net/ipv4/netfilter/ip_conntrack_core.c:124
Message-ID: <20060326231913.GA18750@elte.hu>
References: <1143339628.5527.3.camel@cmn2.stanford.edu> <20060326163056.GC15667@elte.hu> <20060326163450.GA22411@elte.hu> <1143404146.7768.18.camel@cmn3.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143404146.7768.18.camel@cmn3.stanford.edu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:

> On Sun, 2006-03-26 at 18:34 +0200, Ingo Molnar wrote:
> > * Ingo Molnar <mingo@elte.hu> wrote:
> > 
> > > > Mar 23 15:22:48 host kernel: BUG at
> > > > net/ipv4/netfilter/ip_conntrack_core.c:124!
> > > 
> > > does the patch below help?
> > 
> > updated patch below.
> 
> Thanks! I'll test later today. It may take a while to be reasonably 
> sure whether it makes a difference. The hangs have not been frequent.
> 
> If I try a 2.6.16 based kernel, should I also use this patch?

not needed - it's included in -rt10. (-rt9 had it too but was buggy)

	Ingo
