Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261547AbTCWAIK>; Sat, 22 Mar 2003 19:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262181AbTCWAIJ>; Sat, 22 Mar 2003 19:08:09 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:4736 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S261547AbTCWAIJ>; Sat, 22 Mar 2003 19:08:09 -0500
Message-ID: <3E7CFD41.C77CA31D@cinet.co.jp>
Date: Sun, 23 Mar 2003 09:18:09 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.8C-ja  [ja/Vine] (X11; U; Linux 2.5.65-ac2-pc98smp i686)
X-Accept-Language: ja
MIME-Version: 1.0
To: Joe Perches <joe@perches.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH: PC9800 has a slight funny on 8250_pnp
References: <200303211947.h2LJlbig025971@hraefn.swansea.linux.org.uk> <1048364508.23972.5.camel@localhost.localdomain>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Perches wrote:
> 
> On Fri, 2003-03-21 at 11:47, Alan Cox wrote:
> > diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/serial/8250_pnp.c linux-2.5.65-ac2/drivers/serial/8250_pnp.c
> > --- linux-2.5.65/drivers/serial/8250_pnp.c    2003-03-03 19:20:12.000000000 +0000
> > +++ linux-2.5.65-ac2/drivers/serial/8250_pnp.c        2003-03-14 01:07:59.000000000 +0000
> > @@ -188,6 +188,8 @@
> >       {       "MVX00A1",              0       },
> >       /* PC Rider K56 Phone System PnP */
> >       {       "MVX00F2",              0       },
> > +     /* NEC 98NOTE SPEAKER PHONE FAX MODEM(33600bps) */
> > +     {       "nEC8241",              0       },
> 
> Lowercase "n"?  Shouldn't it be "NEC8241"?
This onboard modem returns lowercase 'n'. I don't know it's a bug
 or any other reason. I tested it on many PC-98s, it works fine.

Thanks,
Osamu Tomita
