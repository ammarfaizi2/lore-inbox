Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268147AbUIWC6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268147AbUIWC6j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 22:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268149AbUIWC6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 22:58:39 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:36877 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S268147AbUIWC6i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 22:58:38 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: akpm@osdl.org (Andrew Morton)
Subject: Re: 2.6.9-rc2-mm2
Cc: nuno.ferreira@graycell.biz, linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <20040922190305.4471f6de.akpm@osdl.org>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1CAJoH-0003J3-00@gondolin.me.apana.org.au>
Date: Thu, 23 Sep 2004 12:58:17 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
> 
> hrm.  Lots of changes in fib_hash.c  Could you please try just 2.6.9-rc2 plus
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc2/2.6.9-rc2-mm2/broken-out/linus.patch

I just had a look at mm2 and it's missing davem's latest fix in fib_hash.c:

net/ipv4/fib_hash.c
  1.22 04/09/21 16:31:48 davem@nuts.davemloft.net +1 -1
  [IPV4]: Fix list traversal in fn_hash_insert().

That's probably the problem.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
