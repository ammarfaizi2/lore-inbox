Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269469AbUJWByU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269469AbUJWByU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 21:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269845AbUJWBvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 21:51:18 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:48645 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S269832AbUJWBmk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 21:42:40 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Subject: Re: [PATCH] 8250: Let arch provide the list of leagacy ports	dynamically
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       rmk@arm.linux.org.uk
Organization: Core
In-Reply-To: <1098488236.11740.97.camel@gaston>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1CLAvB-00041B-00@gondolin.me.apana.org.au>
Date: Sat, 23 Oct 2004 11:42:17 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> a #define of an array. This finally allows to fix the problem of
> platforms like ppc and ppc64 for which the same kernel can boot
> machines with and without a 8250, and is necessary to properly deal

That sounds great because we're seeing the same problem with i8042
on ppc/ppc64.  Do you have any plans for that driver?

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
