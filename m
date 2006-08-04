Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161049AbWHDFw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161049AbWHDFw5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 01:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030329AbWHDFw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 01:52:57 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:24590 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1030323AbWHDFwy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 01:52:54 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Subject: Re: problems with e1000 and jumboframes
Cc: arnd@arndnet.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Organization: Core
In-Reply-To: <20060803135925.GA28348@2ka.mipt.ru>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.17-rc4 (i686))
Message-Id: <E1G8sbw-0003mT-00@gondolin.me.apana.org.au>
Date: Fri, 04 Aug 2006 15:52:40 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> 
> But it does not support splitting them into page sized chunks, so it
> requires the whole jumbo frame allocation in one contiguous chunk, 9k
> will be transferred into 16k allocation (order 3), since SLAB uses
> power-of-2 allocation.

Actually order 3 is 32KB.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
