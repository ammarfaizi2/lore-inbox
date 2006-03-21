Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932443AbWCUU0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbWCUU0S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 15:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbWCUU0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 15:26:18 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:56809 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932443AbWCUU0R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 15:26:17 -0500
Date: Tue, 21 Mar 2006 21:24:10 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rt1
Message-ID: <20060321202410.GA22324@elte.hu>
References: <20060320085137.GA29554@elte.hu> <200603211430.29466.Serge.Noiraud@bull.net> <20060321170149.GA27290@elte.hu> <6bffcb0e0603211036i7cce3776p@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bffcb0e0603211036i7cce3776p@mail.gmail.com>
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


* Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:

> Hi Ingo,
> 
> On 21/03/06, Ingo Molnar <mingo@elte.hu> wrote:
> >
> > could you check -rt2?
> >
> 
> Here is first oops http://www.stardust.webpages.pl/files/rt/2.6.16-rt2/b1.jpg
> Here is second oops http://www.stardust.webpages.pl/files/rt/2.6.16-rt2/b2.jpg
> 
> Here is config http://www.stardust.webpages.pl/files/rt/2.6.16-rt2/rt-config
> 
> I can't boot that kernel, 2.6.16-rt1 was fine.

ok, i broke irqs-off latency tracing in -rt2. Could you try -rt3 - it 
should be fixed there.

	Ingo
