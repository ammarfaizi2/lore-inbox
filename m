Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbWGDHlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbWGDHlD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 03:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbWGDHlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 03:41:03 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:39588 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751149AbWGDHlB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 03:41:01 -0400
Date: Tue, 4 Jul 2006 09:36:21 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Miles Lane <miles.lane@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-mm5 + pcmcia/hostap/8139too patches -- inconsistent {hardirq-on-W} -> {in-hardirq-W} usage
Message-ID: <20060704073621.GA7034@elte.hu>
References: <a44ae5cd0607031431q8dcc698j1c447b1d51c7cc75@mail.gmail.com> <1151963034.3108.59.camel@laptopd505.fenrus.org> <1151965557.16528.36.camel@localhost.localdomain> <a44ae5cd0607031614y2055828as6e0bbe2ce0d52ff1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a44ae5cd0607031614y2055828as6e0bbe2ce0d52ff1@mail.gmail.com>
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


* Miles Lane <miles.lane@gmail.com> wrote:

> Arjan, the patch you sent does cause the lockdep message to disappear, 
> but the card doesn't work. [...]

did the card work without the patch? The lockdep messages themselves are 
harmless to functionality, they shouldnt ever break anything, they are 
just information for us to fix potential deadlocks.

	Ingo
