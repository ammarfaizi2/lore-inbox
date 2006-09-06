Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750880AbWIFM6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbWIFM6l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 08:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbWIFM6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 08:58:41 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:54159 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750874AbWIFM6k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 08:58:40 -0400
Date: Wed, 6 Sep 2006 14:50:14 +0200
From: Ingo Molnar <mingo@elte.hu>
To: David Howells <dhowells@redhat.com>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org
Subject: Re: [PATCH] FRV: Fix {dis,en}able_irq_lockdep_irqrestore compile error
Message-ID: <20060906125014.GA3978@elte.hu>
References: <20060905132530.GD9173@stusta.de> <20060901015818.42767813.akpm@osdl.org> <5905.1157469663@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5905.1157469663@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4984]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* David Howells <dhowells@redhat.com> wrote:

> Fix the lack of certain non-LOCKDEP stub functions in 
> linux/interrupt.h and also provide FRV with LOCKDEP variants.
> 
> This is to be applied to -mm kernel since not all of the functions 
> added exist in the main kernel.
> 
> Signed-Off-By: David Howells <dhowells@redhat.com>

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
