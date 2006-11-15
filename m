Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030723AbWKORVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030723AbWKORVf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 12:21:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030728AbWKORVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 12:21:35 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:3040 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030723AbWKORVe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 12:21:34 -0500
Date: Wed, 15 Nov 2006 18:20:03 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Eric Dumazet <dada1@cosmosbay.com>, akpm@osdl.org,
       Arjan van de Ven <arjan@infradead.org>,
       Jeremy Fitzhardinge <jeremy@goop.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386-pda UP optimization
Message-ID: <20061115172003.GA20403@elte.hu>
References: <1158046540.2992.5.camel@laptopd505.fenrus.org> <1158047806.2992.7.camel@laptopd505.fenrus.org> <200611151227.04777.dada1@cosmosbay.com> <200611151232.31937.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611151232.31937.ak@suse.de>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.4
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.4 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0004]
	1.5 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> On Wednesday 15 November 2006 12:27, Eric Dumazet wrote:
> > Seeing %gs prefixes used now by i386 port, I recalled seeing strange 
> > oprofile results on Opteron machines.
> > 
> > I really think %gs prefixes can be expensive in some (most ?) cases, 
> > even if the Intel/AMD docs say they are free.
> 
> They aren't free, just very cheap.

Eric's test shows a 5% slowdown. That's far from cheap.

	Ingo
