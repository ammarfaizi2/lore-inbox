Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270818AbRH1MYF>; Tue, 28 Aug 2001 08:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270823AbRH1MX7>; Tue, 28 Aug 2001 08:23:59 -0400
Received: from mustard.heime.net ([194.234.65.222]:12928 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S270818AbRH1MXq>; Tue, 28 Aug 2001 08:23:46 -0400
Date: Tue, 28 Aug 2001 14:23:57 +0200 (CEST)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Andrew Morton <akpm@zip.com.au>
cc: Jannik Rasmussen <jannik@east.no>, <linux-kernel@vger.kernel.org>
Subject: Re: Error 3c900 driver in 2.2.19?
In-Reply-To: <3B8AD082.DB477F80@zip.com.au>
Message-ID: <Pine.LNX.4.30.0108281423220.1851-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

But...

I haven't seen the problem before 2.2.19. Going back to 2.2.16 solved it

On Mon, 27 Aug 2001, Andrew Morton wrote:

> Well, it shouldn't hang - it should just fail to do anything for a while
> and then recover.
>
> You can reserve more memory for the network driver by altering
> the contents of /proc/sys/vm/freepages.  Try doubling everything
> in there.
>
>
>
> Roy Sigurd Karlsbakk wrote:
> >
> > Hi
> >
> > I have a 3c900 card in a server, and after upgrading to 2.2.19 it started
> > hanging every now and then, giving me the error message "kernel: eth0:
> > memory shortage". The card is this (as reported during boot)
> >
> > 3c59x.c:v0.99H 27May00 Donald Becker
> > http://cesdis.gsfc.nasa.gov/linux/drivers/vortex.html
> > eth0: 3Com 3c900 Boomerang 10Mbps Combo at 0xa800,  00:a0:24:ef:ef:50, IRQ 5
> >   8K word-wide RAM 3:5 Rx:Tx split, 10baseT interface.
> >   Enabling bus-master transmits and whole-frame receives.
> >
> > Please cc: to me (roy@karlsbakk.net) and Jannik (jannik@east.no), as we're
> > not on the list.
> >
> > Best regards
> >
> > roy
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
>

