Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278927AbRKMUuf>; Tue, 13 Nov 2001 15:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278943AbRKMUu1>; Tue, 13 Nov 2001 15:50:27 -0500
Received: from eriador.apana.org.au ([203.14.152.116]:36360 "EHLO
	eriador.apana.org.au") by vger.kernel.org with ESMTP
	id <S278924AbRKMUuU>; Tue, 13 Nov 2001 15:50:20 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: bcollins@debian.org (Ben Collins), linux-kernel@vger.kernel.org
Subject: Re: Differences between 2.2.x and 2.4.x initrd
In-Reply-To: <20011113150317.G329@visi.net>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.14-686-smp (i686))
Message-Id: <E163kVM-0005Rf-00@gondolin.me.apana.org.au>
Date: Wed, 14 Nov 2001 07:50:00 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Collins <bcollins@debian.org> wrote:

> Well, the point being that 2.2.x worked implicitly, and 2.4.x doesn't. I
> don't want to have to tell people who have been using tilo forever and a
> day that they now have to add additional command line to get it to work
> with 2.4.x.

You don't have to.  Just setup linuxrc to echo the right stuff into
/proc/sys/kernel/real-root-dev
-- 
Debian GNU/Linux 2.2 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
