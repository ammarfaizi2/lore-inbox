Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281893AbRLFSLe>; Thu, 6 Dec 2001 13:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281908AbRLFSLY>; Thu, 6 Dec 2001 13:11:24 -0500
Received: from mustard.heime.net ([194.234.65.222]:49352 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S281893AbRLFSLS>; Thu, 6 Dec 2001 13:11:18 -0500
Date: Thu, 6 Dec 2001 19:10:56 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Pablo Borges <pablo.borges@uol.com.br>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.4.16 & Heavy I/O
In-Reply-To: <20011206160630.1f4ab058.pablo.borges@uol.com.br>
Message-ID: <Pine.LNX.4.30.0112061908220.17427-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is it really neccecary? Free memory's a waste! The cache will be discarded
the moment an application needs the memory.

what's the problem? It speeds up disk I/O for recently used files

On Thu, 6 Dec 2001, Pablo Borges wrote:

>
> Don't we have a "dont't eat my whole memory, disk cache" option on linux ?
>
>
> On Wed, 5 Dec 2001 21:07:42 +0100 (CET)
> Roy Sigurd Karlsbakk <roy@karlsbakk.net> wrote:
>
> > > > Absolutely all free memory may be used for disk caching.  So
> > > > no, you can't get a bigger cache because it is already at
> > > > the highest possible setting.  You don't have more memory
> > > > for this - all is used already.
> > >
> > > May I limit this memory ? For a long time I'm working all day with no
> > > physical memory available.
> >
> > You can try rtlinux. In rtlinux (realtime linux), you tell linux how
> > much memory the kernel will have access to, and let specially written
> > apps to take the rest
> > --
> > Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA
> >
> > Computers are like air conditioners.
> > They stop working when you open Windows.
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> > in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>
>
> =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
> Pablo Borges                                pablo.borges@uol.com.br
> -------------------------------------------------------------------
>   ____                                               Tecnologia UOL
>  /    \    Debian:
>  |  =_/      The 100% suck free linux distro.
>   \
>     \      SETI is lame. http://www.distributed.net
>                                                      Dnetc is XNUG!
>

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.


