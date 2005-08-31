Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932497AbVHaL6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932497AbVHaL6K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 07:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932506AbVHaL6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 07:58:10 -0400
Received: from jay.exetel.com.au ([220.233.0.8]:39045 "EHLO jay.exetel.com.au")
	by vger.kernel.org with ESMTP id S932497AbVHaL6I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 07:58:08 -0400
Date: Wed, 31 Aug 2005 21:57:55 +1000
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexey Dobriyan <adobriyan@mail.ru>,
       YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>,
       "David S. Miller" <davem@davemloft.net>,
       Benjamin Reed <breed@users.sourceforge.net>,
       Andy Adamson <andros@citi.umich.edu>, netdev@vger.kernel.org,
       lksctp developers <lksctp-developers@lists.sourceforge.net>,
       Bruce Fields <bfields@umich.edu>, Andy Adamson <andros@umich.edu>,
       linux-net@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto_free_tfm callers do not need to check for NULL
Message-ID: <20050831115755.GA3699@gondor.apana.org.au>
References: <200508302245.55392.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508302245.55392.jesper.juhl@gmail.com>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2005 at 10:45:54PM +0200, Jesper Juhl wrote:
> 
> I've posted similar patches in the past, but was asked to first until the
> short-circuit patch moved from -mm to mainline - and since it is now 
> firmly there in 2.6.13 I assume there's no problem there anymore.
> I was also asked previously to make the patch against mainline and not -mm,
> so this patch is against 2.6.13.

Thanks for you work and patience Jesper, this patch looks good to me.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
