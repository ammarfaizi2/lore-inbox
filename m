Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312393AbSDTTen>; Sat, 20 Apr 2002 15:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312458AbSDTTem>; Sat, 20 Apr 2002 15:34:42 -0400
Received: from pc132.utati.net ([216.143.22.132]:45210 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S312393AbSDTTei>; Sat, 20 Apr 2002 15:34:38 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Christian Schoenebeck <christian.schoenebeck@epost.de>
Subject: Re: power off (again)
Date: Sat, 20 Apr 2002 09:35:58 -0400
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020418201220.C6D6247B1@debian.heim.lan> <20020419230335.6454C755@merlin.webofficenow.com> <20020420123802.4676547B4@debian.heim.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020420195456.93C87730@merlin.webofficenow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 April 2002 09:06 am, Christian Schoenebeck wrote:
> >>> please cc me, I'm offlist <<<
>
> Am Freitag, 19. April 2002 17:52 schrieb Rob Landley:
> > On Friday 19 April 2002 08:58 am, Christian Schoenebeck wrote:
> > > Am Donnerstag, 18. April 2002 23:02 schrieb Trever L. Adams:
> > > > Just out of curiosity, have you changed your power off scripts to
> > > > reflect: "halt -p".
> > >
> > > Yes, this is not the problem
> >
> > Just thought I'd give a "me too" response.  The Red Hat 7.2 kernel powers
> > down all three systems I've tried it on (a Dell Inspiron 3500 laptop, a
> > Toshiba Tecra 8000, and an SIS chipset motherboard).  The 2.4.18 and
> > 2.4.17 kernels do NOT power down any of those systems (It will spins down
> > the hard drive instead, but the system power stays on.  Yes, I'm
> > compiling in the right APM support.  I've tried it both with and without
> > the "use APM bios to power down" switch.)
>
> And I already thought I was the only one having that problem.
>
> Meanwhile Wolfgang Loeffler told me the possibility that power off also
> won't work if you enabled SMP on a uniprocessor machine. It wasn't a
> solution for my machine as I haven't compiled the kernel with SMP support,
> but maybe it's one for yours.

Nope.  SMP is off.

It might be a configuration thing.  Maybe.  I suppose I could compare the red 
hat and 2.4.18 .config files to see if anything obvious jumps out at me.

But it does suspend just fine.  That's the odd part...

Rob
