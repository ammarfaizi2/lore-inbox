Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932525AbWFHH0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932525AbWFHH0t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 03:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932556AbWFHH0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 03:26:48 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:26274 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932525AbWFHH0s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 03:26:48 -0400
Date: Thu, 8 Jun 2006 09:26:08 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: =?iso-8859-1?B?IkouQS4gTWFnYWxs824i?= <jamagallon@ono.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjan@infradead.org>,
       "David S. Miller" <davem@davemloft.net>,
       Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: 2.6.17-rc6-mm1
Message-ID: <20060608072608.GA24794@elte.hu>
References: <20060607104724.c5d3d730.akpm@osdl.org> <20060607232345.3fcad56e@werewolf.auna.net> <20060607220704.GA6287@elte.hu> <44876745.4050108@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44876745.4050108@s5r6.in-berlin.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5019]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:

> The pending_packet_queue is only accessed from within 
> drivers/ieee1394/ieee1394_core.c, and only via net/core/skbuff.c's 
> access functions for queueing/ dequeueing/ queuewalking. Or am I 
> missing something? [...]

yes, and it looks safe at the moment.

	Ingo
