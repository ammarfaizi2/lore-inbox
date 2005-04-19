Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261412AbVDSIVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbVDSIVz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 04:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbVDSIVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 04:21:55 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:27660 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261404AbVDSIVu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 04:21:50 -0400
Date: Tue, 19 Apr 2005 18:20:48 +1000
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: "David S. Miller" <davem@davemloft.net>,
       James Morris <jmorris@intercode.com.au>, linux-crypto@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: resource release functions ought to check for NULL (crypto_free_tfm)
Message-ID: <20050419082048.GA5629@gondor.apana.org.au>
References: <Pine.LNX.4.62.0504150106420.3466@dragon.hyggekrogen.localhost> <20050418114925.GA6854@gondor.apana.org.au> <Pine.LNX.4.62.0504181718540.2480@dragon.hyggekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0504181718540.2480@dragon.hyggekrogen.localhost>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2005 at 05:23:31PM +0200, Jesper Juhl wrote:
> 
> Next step is to then clean up the callers of crypto_free_tfm so they no 
> longer do the redundant NULL check. Below is a patch to do that.

Please wait until the free_tfm change gets into the kernel and then
submit this to the subsystem maintainers, which would all be Dave
in this case :)
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
