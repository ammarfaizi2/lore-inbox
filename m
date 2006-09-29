Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422841AbWI2VtS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422841AbWI2VtS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 17:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422846AbWI2VtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 17:49:18 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:37868 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1422845AbWI2VtQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 17:49:16 -0400
Date: Fri, 29 Sep 2006 23:41:37 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Jim Cromie <jim.cromie@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] fix !apic build breakage
Message-ID: <20060929214137.GB15721@elte.hu>
References: <20060928014623.ccc9b885.akpm@osdl.org> <200609292258.24546.ak@suse.de> <20060929211417.GA11834@elte.hu> <200609292344.55363.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609292344.55363.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> > please dont throw away a perfectly fine config option.
> 
> I can't count how many that silly option already got broken by changes 
> in the APIC code. I definitely wouldn't describe it as "perfectly 
> fine", more as "fragile and tends to fall over when you even look at 
> it".

i disagree. I frequently (daily) boot with apic-on and apic-off configs. 
Very rarely does it break. Today it did, took me 30 seconds and 531 
milliseconds to fix. Spent much more time writing these silly emails ...

	Ingo
