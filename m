Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424820AbWKQAhi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424820AbWKQAhi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 19:37:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424817AbWKQAhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 19:37:38 -0500
Received: from rhun.apana.org.au ([64.62.148.172]:62733 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1424818AbWKQAhh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 19:37:37 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: davem@davemloft.net (David Miller)
Subject: Re: IPv4: ip_options_compile() how can we avoid blowing up on a NULL skb???
Cc: jesper.juhl@gmail.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <20061116.184730.35014107.davem@davemloft.net>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.17-rc4 (i686))
Message-Id: <E1GkrjY-0004Dt-00@gondolin.me.apana.org.au>
Date: Fri, 17 Nov 2006 11:37:32 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller <davem@davemloft.net> wrote:
>
> I'm very happy to accept a patch which assert's this using BUG()
> checks :-)

A BUG() won't be necessary because the NULL pointer dereferences will
OOPS anyway.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
