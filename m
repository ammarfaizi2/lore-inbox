Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261218AbVDSIgS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbVDSIgS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 04:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbVDSIgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 04:36:18 -0400
Received: from mail.dif.dk ([193.138.115.101]:33156 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261188AbVDSIgN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 04:36:13 -0400
Date: Tue, 19 Apr 2005 10:39:12 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>,
       James Morris <jmorris@intercode.com.au>, linux-crypto@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: resource release functions ought to check for
 NULL (crypto_free_tfm)
In-Reply-To: <20050419082048.GA5629@gondor.apana.org.au>
Message-ID: <Pine.LNX.4.62.0504191038410.2480@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0504150106420.3466@dragon.hyggekrogen.localhost>
 <20050418114925.GA6854@gondor.apana.org.au>
 <Pine.LNX.4.62.0504181718540.2480@dragon.hyggekrogen.localhost>
 <20050419082048.GA5629@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Apr 2005, Herbert Xu wrote:

> On Mon, Apr 18, 2005 at 05:23:31PM +0200, Jesper Juhl wrote:
> > 
> > Next step is to then clean up the callers of crypto_free_tfm so they no 
> > longer do the redundant NULL check. Below is a patch to do that.
> 
> Please wait until the free_tfm change gets into the kernel and then
> submit this to the subsystem maintainers, which would all be Dave
> in this case :)

Sure thing, not a problem.

-- 
Jesper

