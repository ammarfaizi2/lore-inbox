Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261403AbUK1G35@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbUK1G35 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 01:29:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbUK1G35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 01:29:57 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:19204 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261403AbUK1G34
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 01:29:56 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
Subject: Re: no entropy and no output at /dev/random  (quick question)
Cc: linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <coak1s$suq$1@abraham.cs.berkeley.edu>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1CYIZ7-0005D3-00@gondolin.me.apana.org.au>
Date: Sun, 28 Nov 2004 17:29:45 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Wagner <daw@taverner.cs.berkeley.edu> wrote:
> 
> Yes, for almost all purposes, applications should use /dev/urandom,
> not /dev/random.  (The names for these devices are unfortunate.)
> Sadly, many applications fail to follow these rules, and consequently
> /dev/random's entropy pool often ends up getting depleted much faster
> than it has to be.

I agree with your conclusion that applications should use urandom.
However, IIRC /dev/urandom depletes the entropy pool just as fast
as /dev/random...

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
