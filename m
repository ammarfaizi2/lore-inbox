Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268137AbTAKTvT>; Sat, 11 Jan 2003 14:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268138AbTAKTvT>; Sat, 11 Jan 2003 14:51:19 -0500
Received: from mail.mediaways.net ([193.189.224.113]:18375 "HELO
	mail.mediaways.net") by vger.kernel.org with SMTP
	id <S268137AbTAKTvS>; Sat, 11 Jan 2003 14:51:18 -0500
Subject: Re: choice of raid5 checksumming algorithm wrong ?
From: Soeren Sonnenburg <kernel@nn7.de>
To: Rene Rebe <rene.rebe@gmx.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030111.203913.846936097.rene.rebe@gmx.net>
References: <1042266405.14440.54.camel@sun> <3E203C00.5060403@inet6.fr>
	 <20030111.203913.846936097.rene.rebe@gmx.net>
Content-Type: text/plain; charset=ISO-8859-1
Organization: 
Message-Id: <1042314720.1225.4.camel@sun>
Mime-Version: 1.0
Date: 11 Jan 2003 20:52:00 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-01-11 at 20:39, Rene Rebe wrote:
> Hi.
> 
> I also consider the kprint message a useability bug - and this is why
> I posted a patch that prints out that the algorithm is choosen to
> write "arround" the L2 cache ... - We patch this in our ROCK Linux
> standard patches ...

I would vote for such a cosmetic patch to be included...

Soeren.

> On: Sat, 11 Jan 2003 16:45:04 +0100,
>     Lionel Bouton <Lionel.Bouton@inet6.fr> wrote:
> > Soeren Sonnenburg wrote:
> > 
> > >Hi!
> > >
> > >I really do wonder whether the displayed message is wrong or why it
> > >always chooses the slowest checksumming function (happens with 2.4.19 -
> > >21pre3)
> > >  
> > >
> > SSE is always preferred because unlike other checksumming code it 
> > doesn't use the processor caches when reading/writing data/checksum.
> > This is slower (if several GB/s can be considered slow) for the 
> > checksumming but far better for the overall system performance.
> > 
> > LB.
> 
> - René
> 
> --  
> René Rebe - Europe/Germany/Berlin
> e-mail:   rene.rebe@gmx.net, rene@rocklinux.org
> web:      www.rocklinux.org, drocklinux.dyndns.org/rene/
> 
> Anyone sending unwanted advertising e-mail to this address will be
> charged $25 for network traffic and computing time. By extracting my
> address from this message or its header, you agree to these terms.


