Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281806AbRLQSHR>; Mon, 17 Dec 2001 13:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281795AbRLQSG6>; Mon, 17 Dec 2001 13:06:58 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:11790 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S281762AbRLQSGh>; Mon, 17 Dec 2001 13:06:37 -0500
Date: Mon, 17 Dec 2001 14:51:34 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Ken Brownfield <brownfld@irridia.com>
Subject: Re: Linux 2.4.17-rc1
In-Reply-To: <E16FTOd-00007M-00@starship.berlin>
Message-ID: <Pine.LNX.4.21.0112171450240.3255-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 16 Dec 2001, Daniel Phillips wrote:

> On December 13, 2001 09:44 pm, Marcelo Tosatti wrote:
> > rc1: 
> > 
> > - Finish MODULE_LICENSE fixups for fs/nls 	(Mark Hymers)
> > - Console race fix				(Andrew Morton/Robert Love)
> > - Configure.help update				(Eric S. Raymond)
> > - Correctly fix Direct IO bug			(Linus Benedict Torvalds)
> > - Turn off aacraid debugging			(Alan Cox)
> > - Added missing spinlocking in do_loopback()	(Alexander Viro)
> > - Added missing __devexit_p() in i82092 
> >   pcmcia driver					(Keith Owens)
> > - ns83820 zerocopy bugfix			(Benjamin LaHaise)
> > - Fix VM problems where cache/buffers didn't get
> >   freed						(me)
> 
> Will there be a rc2?

Yes there will.

There have been reiserfs bug reports (I'm waiting for the fix for -rc2),
and I'm waiting for Richard's patch to fix a devfs update issue.

I want to test those before 2.4.17. 

