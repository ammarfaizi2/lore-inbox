Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261430AbVDSJ1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbVDSJ1h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 05:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbVDSJ1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 05:27:37 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:43277 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261416AbVDSJ1c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 05:27:32 -0400
Date: Tue, 19 Apr 2005 19:25:22 +1000
To: "Artem B. Bityuckiy" <dedekind@yandex.ru>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
       Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [RFC] CryptoAPI & Compression
Message-ID: <20050419092522.GA5979@gondor.apana.org.au>
References: <20050403093044.GA20608@gondor.apana.org.au> <424FBB56.5090503@yandex.ru> <20050403100043.GA20768@gondor.apana.org.au> <1112522762.3899.182.camel@localhost.localdomain> <20050403101752.GA20866@gondor.apana.org.au> <1112527158.3899.213.camel@localhost.localdomain> <20050403114045.GA21255@gondor.apana.org.au> <4250175D.5070704@yandex.ru> <20050403213207.GA24462@gondor.apana.org.au> <4263CDA9.7070207@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4263CDA9.7070207@yandex.ru>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please keep linux-crypto@vger.kernel.org in the loop.

On Mon, Apr 18, 2005 at 07:09:29PM +0400, Artem B. Bityuckiy wrote:
>
> Actually, for JFFS2 we need to leave the uncompressable data 
> uncompressed. So if the pcompress interface have only been for JFFS2, 
> I'd just return an error rather then expand data. Is such behavior 
> acceptable for common Linux's parts pike CryptoAPI ?

You mean you no longer need pcompress and we can get rid of it?
That's fine by me.

> And more, frankly, I don't like the "independent" partial compression 
> approach in JFFS2 and in JFFS3 (if it will ever happen) I'd make these 
> pieces dependent. For this purpose we'd need some deflate-like CryptoAPI 
> interface. I'm not going to implement it at the moment, I'm just curious 
> - what do you guys think about a generalized deflate-like CryptoAPI 
> compression interface?

Well if you can show me what such an interface looks like then we can
discuss it.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
