Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314281AbSESJGr>; Sun, 19 May 2002 05:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314282AbSESJGq>; Sun, 19 May 2002 05:06:46 -0400
Received: from as2-1-8.va.g.bonet.se ([194.236.117.122]:42195 "EHLO
	ringstrom.mine.nu") by vger.kernel.org with ESMTP
	id <S314281AbSESJGq>; Sun, 19 May 2002 05:06:46 -0400
Date: Sun, 19 May 2002 11:06:30 +0200 (CEST)
From: Tobias Ringstrom <tori@ringstrom.mine.nu>
X-X-Sender: tori@boris.prodako.se
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
cc: casdcsdc sdfccsdcsd <computrius@yahoo.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: davicom 9102 and linux 2.5
In-Reply-To: <20020518181821.GA3683@conectiva.com.br>
Message-ID: <Pine.LNX.4.44.0205191056070.31419-100000@boris.prodako.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 May 2002, Arnaldo Carvalho de Melo wrote:

> Em Sat, May 18, 2002 at 04:58:54PM -0700, casdcsdc sdfccsdcsd escreveu:
> > I just tryed to comile and install the 2.5 linux kernel, and I noticed
> > something that compleatly stumped me, as well as pissed me off. YOU TOOK OUT
> > THE DRIVER FOR DAVICOM 9102 NETWORK CARD! WHY?!? it doesnt make any sense,
> > when you make a new version, you ADD FEATURES, YOU DONT TAKE THEM OUT!
> 
> Calm down casdcsdc! :) Look at the docs (and grep the sources ;) )... it seems
> it is now supported by the tulip driver, see:

That has been true for a long time.  The only difference is that the 
driver has been moved to drivers/net/tulip/dmfe.c and the configure option 
has been hidden under Network device support / "Tulip" family network 
device support".

Jeff, would you care to enlighten us as to why this was done?  To educate
users that the Davicom chip is really a (bad) tulip clone?

Are you planning to reorgonize the "Network device support" menu as a
whole?  It's a mess.

/Tobias


