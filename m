Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261695AbVDCLnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbVDCLnP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 07:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbVDCLnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 07:43:11 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:27659 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261684AbVDCLmZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 07:42:25 -0400
Date: Sun, 3 Apr 2005 21:42:07 +1000
To: "Artem B. Bityuckiy" <dedekind@yandex.ru>
Cc: David Woodhouse <dwmw2@infradead.org>,
       "Artem B. Bityuckiy" <dedekind@infradead.org>,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [RFC] CryptoAPI & Compression
Message-ID: <20050403114207.GB21255@gondor.apana.org.au>
References: <20050401221303.GA6557@gondor.apana.org.au> <424FA7B4.6050008@yandex.ru> <20050403084415.GA20326@gondor.apana.org.au> <424FB06B.3060607@yandex.ru> <20050403093044.GA20608@gondor.apana.org.au> <424FBB56.5090503@yandex.ru> <20050403100043.GA20768@gondor.apana.org.au> <1112522762.3899.182.camel@localhost.localdomain> <20050403101752.GA20866@gondor.apana.org.au> <424FC42E.80503@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424FC42E.80503@yandex.ru>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 03, 2005 at 02:23:42PM +0400, Artem B. Bityuckiy wrote:
>
> It must not. Look at the algoritm closer.

This relies on implementation details within zlib_deflate, which may
or may not be the case.

It should be easy to test though.  Just write a user-space program
which does exactly this and feed it something from /dev/urandom.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
