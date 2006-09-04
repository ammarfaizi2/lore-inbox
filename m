Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965004AbWIDWMe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965004AbWIDWMe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 18:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965009AbWIDWMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 18:12:34 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:19975 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S965004AbWIDWMc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 18:12:32 -0400
Date: Tue, 5 Sep 2006 08:12:21 +1000
To: Valdis.Kletnieks@vt.edu
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc4-mm3 crypto issues with encrypted disks
Message-ID: <20060904221221.GA31911@gondor.apana.org.au>
References: <200609041602.k84G2SYc005390@turing-police.cc.vt.edu> <200609042125.k84LPMYR003633@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609042125.k84LPMYR003633@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2006 at 05:25:22PM -0400, Valdis.Kletnieks@vt.edu wrote:
> 
> -# Linux kernel version: 2.6.18-rc4-mm3
> -# Wed Aug 30 10:00:30 2006
> +# Linux kernel version: 2.6.18-rc5-mm1
> +# Mon Sep  4 16:22:37 2006
> ....
> +CONFIG_CRYPTO_ALGAPI=y
> +CONFIG_CRYPTO_BLKCIPHER=y
> +CONFIG_CRYPTO_HASH=y
> +CONFIG_CRYPTO_MANAGER=y
> 
> Does 'CONFIG_CRYPTOLOOP' need a 'SELECT CRYPTO_MANAGER' (or one of the other
> symbols)?

All of these symbols default to m so they should have selected themselves.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
