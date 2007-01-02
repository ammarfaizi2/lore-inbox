Return-Path: <linux-kernel-owner+w=401wt.eu-S1754370AbXABCYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754370AbXABCYJ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 21:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755040AbXABCYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 21:24:09 -0500
Received: from rhun.apana.org.au ([64.62.148.172]:1622 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754370AbXABCYH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 21:24:07 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: jeff@garzik.org (Jeff Garzik)
Subject: Re: [git patches] net driver fixes
Cc: akpm@osdl.org, torvalds@osdl.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <20061226224646.GA10417@havoc.gtf.org>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.17-rc4 (i686))
Message-Id: <E1H1ZJf-0002cA-00@gondolin.me.apana.org.au>
Date: Tue, 02 Jan 2007 13:23:51 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jeff@garzik.org> wrote:
> 
>      e1000: Do not truncate TSO TCP header with 82544 workaround

This change obsoletes the following change.

>      e1000: disable TSO on the 82544 with slab debugging

So the slab debugging patch should be reverted.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
