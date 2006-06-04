Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932158AbWFDKMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbWFDKMQ (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 06:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbWFDKMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 06:12:16 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:63979 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932158AbWFDKMP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 06:12:15 -0400
Date: Sun, 4 Jun 2006 12:11:36 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: "Barry K. Nathan" <barryn@pobox.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@osdl.org>
Subject: Re: [patch, -rc5-mm3] lock validator: fix ns83820.c irq-flags part 3
Message-ID: <20060604101136.GA14693@elte.hu>
References: <20060604083017.GA8241@elte.hu> <1149411525.3109.73.camel@laptopd505.fenrus.org> <986ed62e0606040253pfe9c300qf88029f88ae65039@mail.gmail.com> <1149415707.3109.96.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149415707.3109.96.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5069]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Arjan van de Ven <arjan@linux.intel.com> wrote:

> On Sun, 2006-06-04 at 02:53 -0700, Barry K. Nathan wrote:
> > On 6/4/06, Arjan van de Ven <arjan@linux.intel.com> wrote:
> > > just the preempt the next email from Barry; while fixing this one I
> > > looked at the usage of the locks more and found another patch needed...
> > [snip]
> > 
> > Nice try, but it didn't work. ~_^
> > 
> > I was about to reply to the previous ns83820 patch with my dmesg, when
> > I saw this one. I applied this patch too, and like the previous patch,
> > it reports an instance of illegal lock usage. My dmesg follows.
> > -- 
> 
> ok this is a real driver deadlock:

preexisting bug, right? So this fix should go into 2.6.16/17 too, 
correct?

	Ingo
