Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261706AbVDCMBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbVDCMBd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 08:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbVDCMBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 08:01:33 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:57099 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261702AbVDCMB2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 08:01:28 -0400
Date: Sun, 3 Apr 2005 22:00:20 +1000
To: "Artem B. Bityuckiy" <dedekind@yandex.ru>
Cc: "Artem B. Bityuckiy" <dedekind@infradead.org>, dwmw2@infradead.org,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       jmorris@redhat.com, svenning@post5.tele.dk,
       YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
Subject: Re: [RFC] CryptoAPI & Compression
Message-ID: <20050403120020.GA21388@gondor.apana.org.au>
References: <1111766900.4566.20.camel@sauron.oktetlabs.ru> <20050326044421.GA24358@gondor.apana.org.au> <1112030556.17983.35.camel@sauron.oktetlabs.ru> <20050331095151.GA13992@gondor.apana.org.au> <424FD653.7020204@yandex.ru> <20050403114704.GC21255@gondor.apana.org.au> <424FD944.7080606@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424FD944.7080606@yandex.ru>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 03, 2005 at 03:53:40PM +0400, Artem B. Bityuckiy wrote:
> Herbert Xu wrote:
> >Can you please point me to the paragraph in RFC 1950 that says this?
> 
> Ok, if to do s/correct/compliant/, here it is:
> 
> Section 2.3, page 7

Sorry, I thought you were referring to an RFC that defined IPComp/deflate.

RFC 1950 only defines what a zlib compressed data stream should
look like, it does not define what a deflate compressed data
stream is.

RFC 2394 which defines IPComp/deflate only refers to the deflate
document, and not zlib.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
