Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945964AbWGOBZw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945964AbWGOBZw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 21:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945962AbWGOBZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 21:25:51 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:57607 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1945960AbWGOBZv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 21:25:51 -0400
Date: Sat, 15 Jul 2006 11:25:48 +1000
To: Michal Ludvig <michal@logix.cz>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [CRYPTO] padlock: Fix alignment after aes_ctx rearrange
Message-ID: <20060715012548.GA13202@gondor.apana.org.au>
References: <44B6FC90.2060501@logix.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44B6FC90.2060501@logix.cz>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2006 at 02:08:16PM +1200, Michal Ludvig wrote:
> 
> I just recently discovered that your patch that rearranges struct
> aes_ctx in padlock-aes.c breaks the alignment rules for xcrypt leading
> to GPF Oopses.

Thanks a lot for catching this.

I've pushed the bug fix along.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
