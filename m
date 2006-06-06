Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751001AbWFFTeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbWFFTeA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 15:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751011AbWFFTeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 15:34:00 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:49055 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751001AbWFFTd7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 15:33:59 -0400
Date: Tue, 6 Jun 2006 21:33:25 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch, -rc5-mm3] lock validator: -V3
Message-ID: <20060606193325.GA16010@elte.hu>
References: <20060606154530.GA11063@elte.hu> <20060606091515.27db4746.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060606091515.27db4746.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> On Tue, 6 Jun 2006 17:45:30 +0200
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> >  30 files changed, 545 insertions(+), 230 deletions(-)
> 
> This basically screws up the whole patch series.  It'll create a 
> barrier over which it will be hard to move fixups against existing 
> patches.

yes. Dont worry about it, i'll refactor the whole lock validator queue 
once i've done the cleanups too.

> ho-hum.  Let's make sure that future patches are extremely 
> fine-grained and please try to identify whether they're applicable to 
> -v2 or to -v3 and we'll see how it goes.

there was just no other way to do this - this change is intrusive 
independently of how finegrained the patches are.

	Ingo
