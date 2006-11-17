Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424764AbWKQF2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424764AbWKQF2c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 00:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162362AbWKQF2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 00:28:32 -0500
Received: from rhun.apana.org.au ([64.62.148.172]:48900 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1162231AbWKQF2b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 00:28:31 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: dtor@insightbb.com (Dmitry Torokhov)
Subject: Re: IPv4: ip_options_compile() how can we avoid blowing up on a NULL skb???
Cc: herbert@gondor.apana.org.au, davem@davemloft.net, jesper.juhl@gmail.com,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <200611162246.21018.dtor@insightbb.com>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.17-rc4 (i686))
Message-Id: <E1GkwGq-0004tw-00@gondolin.me.apana.org.au>
Date: Fri, 17 Nov 2006 16:28:12 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dtor@insightbb.com> wrote:
> 
> BUG()s there would be a mechanism to document invariants so next time
> someone is looking at the code there are no questions.

Well if someone is documenting this then wouldn't a comment (or even a
kerneldoc style block) be better?

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
