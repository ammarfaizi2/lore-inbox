Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261636AbVDCJcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261636AbVDCJcJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 05:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbVDCJcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 05:32:09 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:17673 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261627AbVDCJcF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 05:32:05 -0400
Date: Sun, 3 Apr 2005 19:30:44 +1000
To: "Artem B. Bityuckiy" <dedekind@yandex.ru>
Cc: "Artem B. Bityuckiy" <dedekind@infradead.org>, dwmw2@infradead.org,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [RFC] CryptoAPI & Compression
Message-ID: <20050403093044.GA20608@gondor.apana.org.au>
References: <E1DGxa7-0000GH-00@gondolin.me.apana.org.au> <Pine.LNX.4.58.0504011534460.9305@phoenix.infradead.org> <20050401152325.GB4150@gondor.apana.org.au> <Pine.LNX.4.58.0504011640340.9305@phoenix.infradead.org> <20050401221303.GA6557@gondor.apana.org.au> <424FA7B4.6050008@yandex.ru> <20050403084415.GA20326@gondor.apana.org.au> <424FB06B.3060607@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424FB06B.3060607@yandex.ru>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 03, 2005 at 12:59:23PM +0400, Artem B. Bityuckiy wrote:
> 
> Err, it looks like we've lost the conversation flow. :-) I commented 
> your phrase: "The question is what happens when you compress 1 1GiB 
> input buffer into a 1GiB output buffer."
> 
> Then could you please in a nutshell write what worries you or what issue 
> you would like to clarify?
> 
> IIRC, you worried that in case of a large input and output 12 bytes 
> won't be enough. I argued it should. I'm even going to check this soon :-)

You can't compress 1M-12bytes into 1M using zlib when the block size
is 64K.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
