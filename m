Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932366AbWGJKmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbWGJKmz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 06:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbWGJKmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 06:42:55 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:10170 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932366AbWGJKmy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 06:42:54 -0400
Date: Mon, 10 Jul 2006 12:37:24 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.18-rc1-mm1
Message-ID: <20060710103724.GA10602@elte.hu>
References: <20060709021106.9310d4d1.akpm@osdl.org> <6bffcb0e0607090332i477d594fq9ef96721574ae91b@mail.gmail.com> <20060709035203.cdc3926f.akpm@osdl.org> <20060710074039.GA26853@elte.hu> <6bffcb0e0607100222m5cbdba31ia39d47f3f1f94b26@mail.gmail.com> <20060710092528.GA8455@elte.hu> <6bffcb0e0607100301j1fa444au2c3ecd7128e126ef@mail.gmail.com> <6bffcb0e0607100337v41cb807eta26a2aa370e582ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bffcb0e0607100337v41cb807eta26a2aa370e582ff@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5018]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:

> On 10/07/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> >On 10/07/06, Ingo Molnar <mingo@elte.hu> wrote:
> >> ah, ok. So i'll put this under the 'unclean-build artifact' section,
> >> i.e. not a lockdep bug for now, it seems. Please re-report if it ever
> >> occurs again with a clean kernel build.
> >
> >Unfortunately "make O=/dir clean" doesn't help. I'll disable lockdep,
> >and see what happens.
> >
>
> When I set DEBUG_LOCK_ALLOC=n and CONFIG_PROVE_LOCKING=n everything is 
> ok. It maybe a gcc 4.2 bug.

well ... if you disable lockdep then you wont get lockdep messages - 
that's normal. Or did i miss what the bug is about?

	Ingo
