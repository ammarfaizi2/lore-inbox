Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262942AbVDAWSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262942AbVDAWSH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 17:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262918AbVDAWOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 17:14:33 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:21005 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262925AbVDAWOD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 17:14:03 -0500
Date: Sat, 2 Apr 2005 08:13:03 +1000
To: "Artem B. Bityuckiy" <dedekind@infradead.org>
Cc: dwmw2@infradead.org, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org
Subject: Re: [RFC] CryptoAPI & Compression
Message-ID: <20050401221303.GA6557@gondor.apana.org.au>
References: <E1DGxa7-0000GH-00@gondolin.me.apana.org.au> <Pine.LNX.4.58.0504011534460.9305@phoenix.infradead.org> <20050401152325.GB4150@gondor.apana.org.au> <Pine.LNX.4.58.0504011640340.9305@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504011640340.9305@phoenix.infradead.org>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2005 at 04:41:44PM +0100, Artem B. Bityuckiy wrote:
> 
> Suppose we compress 1 GiB of input, and have a 70K output buffer. We 

The question is what happens when you compress 1 1GiB input buffer into
a 1GiB output buffer.

> Surely I'll check. I'll even test the new implementation (which I didn't 
> actually do) with a large input before sending it next time.

It'd be a good idea to use /dev/urandom as your input.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
