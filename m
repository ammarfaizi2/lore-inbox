Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275743AbRKSJRv>; Mon, 19 Nov 2001 04:17:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276477AbRKSJRl>; Mon, 19 Nov 2001 04:17:41 -0500
Received: from eriador.apana.org.au ([203.14.152.116]:9998 "EHLO
	eriador.apana.org.au") by vger.kernel.org with ESMTP
	id <S276361AbRKSJR2>; Mon, 19 Nov 2001 04:17:28 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: viro@math.psu.edu (Alexander Viro), linux-kernel@vger.kernel.org
Subject: Re: more fun with procfs (netfilter)
In-Reply-To: <Pine.GSO.4.21.0111190215390.17210-100000@weyl.math.psu.edu>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.14-686-smp (i686))
Message-Id: <E165kY1-0000Se-00@gondolin.me.apana.org.au>
Date: Mon, 19 Nov 2001 20:17:01 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro <viro@math.psu.edu> wrote:

> PS: with bash-2.03:
> $ while read i; do echo $i; done < /proc/ip_tables_names
> $ while read i; do echo $i; done < /proc/ip_conntrack
> $
> 'cause this beast reads byte-by-byte...

Actually, there is no easy way of implementing a read(1) that doesn't
read byte-by-byte...
-- 
Debian GNU/Linux 2.2 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
