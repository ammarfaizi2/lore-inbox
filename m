Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751583AbWEaViA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751583AbWEaViA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 17:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965173AbWEaViA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 17:38:00 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:54419 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751583AbWEaVh7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 17:37:59 -0400
Date: Wed, 31 May 2006 23:38:17 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch, -rc5-mm1] locking validator: special rule: 3c59x.c disable_irq()
Message-ID: <20060531213817.GA3739@elte.hu>
References: <20060531200900.GA32482@elte.hu> <1149107540.9978.5.camel@localhost.localdomain> <20060531203609.GA882@elte.hu> <1149111155.9978.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149111155.9978.8.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5034]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 2006-05-31 at 22:36 +0200, Ingo Molnar wrote:
> > *
> > 
> > i've updated it now, please check it out. (i sent the generic 
> > disable_irq_lockdep() bits to lkml separately but forgot to Cc: you)
> > 
> 
> I've just booted it on my i386 SMP (with the vortex card) and it 
> hasn't reported anything yet.
> 
> Looks good, I'll let you know if I find anything else.

great and thanks for the testing!

	Ingo
