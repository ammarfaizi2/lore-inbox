Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266161AbSL1JIS>; Sat, 28 Dec 2002 04:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266160AbSL1JIS>; Sat, 28 Dec 2002 04:08:18 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:5558 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S266125AbSL1JIQ>; Sat, 28 Dec 2002 04:08:16 -0500
Date: Sat, 28 Dec 2002 10:16:08 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Samuel Flory <sflory@rackable.com>, "Justin T. Gibbs" <gibbs@scsiguy.com>,
       Janet Morgan <janetmor@us.ibm.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] aic7xxx bouncing over 4G
Message-ID: <20021228091608.GA13814@louise.pinerecords.com>
References: <200212210012.gBL0Cng21338@eng2.beaverton.ibm.com> <176730000.1040430221@aslan.btc.adaptec.com> <3E03BB0D.5070605@rackable.com> <Pine.LNX.4.50L.0212280331110.30646-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50L.0212280331110.30646-100000@freak.distro.conectiva>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [marcelo@conectiva.com.br]
>
> > >>I have an Adaptec AIC-7897 Ultra2 SCSI adapter on a system with 8G
> > >>of physical memory.  The adapter is using bounce buffers when DMA'ing
> > >>to memory >4G because of a bug in the aic7xxx driver.
> > >>
> > >>
> > >
> > >This has been fixed in both the aic7xxx and aic79xx drivers for some
> > >time.  The problem is that these later revisions have not been integrated
> > >into the mainline trees.
> > >
> > >
> > >
> >   Marcelo, what is required get the aic79xx driver, and the aic7xxx
> > updates into 2.4.21?  A number of linux distros are already using it.
> >  It would really help people using board with the U320.
> >
> >     I've been using both drivers for some time with no issues.  Or maybe
> > you'd prefer Alan put it in his tree 1st?
> 
> Ho, hum, I prefer getting it tested in -ac for a while first.

Marcelo, you've been overlooking these updates for a bit too long now
for your "let's throw them at -ac" to sound fair.  IMHO of course.  Also
remember those are both production drivers tested thoroughly in FreeBSD,
plus you have your own testing releases -- or at least that's how I thought
'-pre' was meant, and so did Pete Zaitcev apparently
(Message-ID: <20021217142235.C8233@devserv.devel.redhat.com>). <g>

-- 
Tomas Szepe <szepe@pinerecords.com>
