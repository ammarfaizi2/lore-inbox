Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265545AbTFVFgq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 01:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265549AbTFVFgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 01:36:46 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:20493 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S265545AbTFVFgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 01:36:45 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Isapnp warning
In-Reply-To: <20030621195928.13ef95ea.akpm@digeo.com>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.5.17-20030301 ("Bubbles") (UNIX) (Linux/2.4.21-1-686-smp (i686))
Message-Id: <E19Txk4-0006wJ-00@gondolin.me.apana.org.au>
Date: Sun, 22 Jun 2003 15:50:20 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> wrote:
> 
> Alignment mainly.  It pads stuff all over the place.  A lot of it can be
> defeated - but not all, last time I looked.

And if you're compiling for i386, the main increase comes from
out-of-line branches.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
