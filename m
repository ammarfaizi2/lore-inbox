Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281916AbRLFSaF>; Thu, 6 Dec 2001 13:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282042AbRLFS36>; Thu, 6 Dec 2001 13:29:58 -0500
Received: from toole.uol.com.br ([200.231.206.186]:6654 "EHLO toole.uol.com.br")
	by vger.kernel.org with ESMTP id <S281916AbRLFS3o>;
	Thu, 6 Dec 2001 13:29:44 -0500
Date: Thu, 6 Dec 2001 16:28:51 -0200
From: Pablo Borges <pablo.borges@uol.com.br>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.16 & Heavy I/O
Message-Id: <20011206162851.41a06794.pablo.borges@uol.com.br>
In-Reply-To: <Pine.LNX.4.30.0112061908220.17427-100000@mustard.heime.net>
In-Reply-To: <20011206160630.1f4ab058.pablo.borges@uol.com.br>
	<Pine.LNX.4.30.0112061908220.17427-100000@mustard.heime.net>
Organization: UOL Inc
X-Mailer: Sylpheed version 0.6.5claws17 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


So ppl, plz help-me find this problem.

Once upon a time, I had 30/60 days uptime on my workstation, only rebooting for kernel updates or power faults. Nowadays, I've to reboot my machine every day because there's no physical memory available. I watch my disk burning in heavy I/O to open my X, browser, etc and stuff.

Then, one day, I decided to init 1; umount all and I saw the amazing release of 70% for my physical memory. I assumed that the disk cache had it all.

So, if this is correct, I want or to keep the cache under control or to flush it when I want. François Cami told me there is an option on aa's VM that helps me with that

> easy.
> echo 400 > /proc/sys/vm/vm_mapped_ratio
> the higher the number, the smaller/less aggressive the disk cache.

Tnx for your help,
[]'s
Pablo

On Thu, 6 Dec 2001 19:10:56 +0100 (CET)
Roy Sigurd Karlsbakk <roy@karlsbakk.net> wrote:

> Is it really neccecary? Free memory's a waste! The cache will be
> discarded the moment an application needs the memory.
> 
> what's the problem? It speeds up disk I/O for recently used files
> 
> On Thu, 6 Dec 2001, Pablo Borges wrote:
> 
> >
> > Don't we have a "dont't eat my whole memory, disk cache" option on
> > linux ?
> >
> >
> > On Wed, 5 Dec 2001 21:07:42 +0100 (CET)
> > Roy Sigurd Karlsbakk <roy@karlsbakk.net> wrote:
> >
> > > > > Absolutely all free memory may be used for disk caching.  So
> > > > > no, you can't get a bigger cache because it is already at
> > > > > the highest possible setting.  You don't have more memory
> > > > > for this - all is used already.
> > > >
> > > > May I limit this memory ? For a long time I'm working all day with
> > > > no physical memory available.
> > >
> > > You can try rtlinux. In rtlinux (realtime linux), you tell linux how
> > > much memory the kernel will have access to, and let specially
> > > written apps to take the rest
> > > --
> > > Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA
> > >
> > > Computers are like air conditioners.
> > > They stop working when you open Windows.
> > >
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe
> > > linux-kernel" in the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> > >
> >
> >
> > =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
> > Pablo Borges                                pablo.borges@uol.com.br
> > -------------------------------------------------------------------
> >   ____                                               Tecnologia UOL
> >  /    \    Debian:
> >  |  =_/      The 100% suck free linux distro.
> >   \
> >     \      SETI is lame. http://www.distributed.net
> >                                                      Dnetc is XNUG!
> >
> 
> --
> Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA
> 
> Computers are like air conditioners.
> They stop working when you open Windows.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
Pablo Borges                                pablo.borges@uol.com.br
-------------------------------------------------------------------
  ____                                               Tecnologia UOL
 /    \    Debian:
 |  =_/      The 100% suck free linux distro.
  \
    \      SETI is lame. http://www.distributed.net
                                                     Dnetc is XNUG!

