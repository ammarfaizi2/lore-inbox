Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261617AbREXL7B>; Thu, 24 May 2001 07:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261628AbREXL6v>; Thu, 24 May 2001 07:58:51 -0400
Received: from eriador.apana.org.au ([203.14.152.116]:28684 "EHLO
	eriador.apana.org.au") by vger.kernel.org with ESMTP
	id <S261617AbREXL6k>; Thu, 24 May 2001 07:58:40 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: viro@math.psu.edu (Alexander Viro), linux-kernel@vger.kernel.org
Subject: Re: Busy on BLKFLSBUF w/initrd
In-Reply-To: <Pine.GSO.4.21.0105240724000.21818-100000@weyl.math.psu.edu>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.4-686-smp (i686))
Message-Id: <E152tkM-0003T8-00@gondolin.me.apana.org.au>
Date: Thu, 24 May 2001 21:57:42 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro <viro@math.psu.edu> wrote:

> Erm... You pin the inode down. That makes filesystem busy by any
> definition I can think of...

That's just because the 2.4.4 code doesn't release it with a blkdev_put.
The fix is in the ac patches.
-- 
Debian GNU/Linux 2.2 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
