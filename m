Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263308AbRFKAOY>; Sun, 10 Jun 2001 20:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263313AbRFKAOO>; Sun, 10 Jun 2001 20:14:14 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:62482 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263308AbRFKAOJ>; Sun, 10 Jun 2001 20:14:09 -0400
Date: Sun, 10 Jun 2001 17:13:40 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: egger@suse.de
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4.5-ac12] New Sony Vaio Motion Eye camera driver
In-Reply-To: <20010611014012.CB4ABA6C6@Nicole.muc.suse.de>
Message-ID: <Pine.LNX.4.21.0106101659380.2242-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 11 Jun 2001 egger@suse.de wrote:
>
> On 10 Jun, Linus Torvalds wrote:
> 
> > I've not figured out why the ATI Xv stuff from gatos seems to not have
> > made it into the XFree86 CVS tree - it works better than much of the
> > Xv stuff for some other chipsets that _are_ in the CVS tree.
> >  
> > I imported it into the XFree86 CVS some months ago, it was trivial.  I
> > don't have the patches lying around any more, though. I can try to
> > re-create them if anybody needs help.
> 
>  Did it look endiansafe to you? The ATI Xv stuff from XFree86 4.1.0
>  produces psychadelic results for me on PPC.

I have to say that I have absolutely no idea. I only use little-endian
machines myself (and 99% x86).

Also, which ATI Xv stuff are you talking about? The ATI Rage128 and ATI
Radeon Xv code was at least a few months ago completely separate from the
ATI Rage code (the first two were in X CVS, while the latter only existed
in the gatos version). 

Has the Gatos code (or some other code) maybe been integrated into 4.1.0
now? I haven't followed X CVS for the last months very closely..

		Linus

