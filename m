Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932288AbWDGFt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbWDGFt4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 01:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbWDGFtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 01:49:55 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:40210 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S932272AbWDGFtz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 01:49:55 -0400
Date: Fri, 7 Apr 2006 15:49:51 +1000
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] crypto: add alignment handling to digest layer
Message-ID: <20060407054951.GA29737@gondor.apana.org.au>
References: <20060405180520.GA15151@gondor.apana.org.au> <20060406.113742.15248428.nemoto@toshiba-tops.co.jp> <20060406232454.GA27623@gondor.apana.org.au> <20060407.142755.55146269.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060407.142755.55146269.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2006 at 02:27:55PM +0900, Atsushi Nemoto wrote:
> 
> It seems modern gcc (at least gcc 3.4 on i386 and mips) can allocate
> the buffer conditionally.  It is better to optimize for newer gcc,
> isn't it?

Of course it does.  I must've been confused.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
