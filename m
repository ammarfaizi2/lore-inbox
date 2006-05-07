Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbWEGMeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbWEGMeI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 08:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbWEGMeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 08:34:07 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:262 "EHLO arnor.apana.org.au")
	by vger.kernel.org with ESMTP id S932138AbWEGMeG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 08:34:06 -0400
Date: Sun, 7 May 2006 22:33:53 +1000
To: Andi Kleen <ak@suse.de>
Cc: Joachim Fritschi <jfritschi@freenet.de>, davem@davemloft.net,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [RFC][PATCH 2/2]  Twofish cipher x86_64-asm optimized
Message-ID: <20060507123353.GA4611@gondor.apana.org.au>
References: <200605071157.03362.jfritschi@freenet.de> <p73odya3ys9.fsf@bragg.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73odya3ys9.fsf@bragg.suse.de>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 07, 2006 at 12:38:30PM +0200, Andi Kleen wrote:
> 
> It would be good if you could run some random input encrypt/decrypt tests 
> comparing the C reference version with yours. We have had bad luck 
> with assembler functions not quite implementing the same cipher 
> in the past.

That's a very good point.  The tcrypt module provides both correctness
tests as well as speed tests for twofish.  Please run it with your
version versus the existing implementation.

BTW, crypto stuff should cc linux-crypto@vger.kernel.org.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
