Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270667AbRHJWvA>; Fri, 10 Aug 2001 18:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270668AbRHJWuu>; Fri, 10 Aug 2001 18:50:50 -0400
Received: from eriador.apana.org.au ([203.14.152.116]:48135 "EHLO
	eriador.apana.org.au") by vger.kernel.org with ESMTP
	id <S270667AbRHJWuo>; Fri, 10 Aug 2001 18:50:44 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
Subject: Re: Remotely rebooting a machine with state 'D' processes, how?
In-Reply-To: <200108102159.f7ALxb908284@penguin.transmeta.com>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.7-686-smp (i686))
Message-Id: <E15VL6x-0007Jm-00@gondolin.me.apana.org.au>
Date: Sat, 11 Aug 2001 08:50:35 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> wrote:
> In article <20010810231906.A21435@bonzo.nirvana> you write:

> You have to use the reboot() system call directly as root, with the
> proper arguments to make it avoid doing even any sync. See

>        man 2 reboot

How do you do this when the process in the D state is holding the BKL?
-- 
Debian GNU/Linux 2.2 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
