Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317761AbSFLSsk>; Wed, 12 Jun 2002 14:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317762AbSFLSsj>; Wed, 12 Jun 2002 14:48:39 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:55818
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S317761AbSFLSsi>; Wed, 12 Jun 2002 14:48:38 -0400
Date: Wed, 12 Jun 2002 11:32:22 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Bill Davidsen <davidsen@tmr.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Nick Evgeniev <nick@octet.spb.ru>,
        linux-kernel@vger.kernel.org
Subject: Re: linux 2.4.19-preX IDE bugs
In-Reply-To: <Pine.LNX.3.96.1020612095106.337A-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.10.10206121130160.15604-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Bill,

The hardware changed and the interrupt parser feature that stablized the
old chipsets under SMP is gone.  The new chipsets (20268 and above) do not
have a location with sticky bits.  So in some cases I expect things to go
south, but in general they should not.  Otherwise promise would be all
over the issue.

Cheers,

On Wed, 12 Jun 2002, Bill Davidsen wrote:

> On Wed, 12 Jun 2002, Alan Cox wrote:
> 
> > >   I agree that if it has known problems which destroy data it should be
> > > unavailable in the stable kernel. It certainly sounds as if that's the
> > > case, and the driver could be held out until 2.4.20 or so when it can be
> > > fixed, or if it can't be fixed it can just go away.
> > 
> > Then I suggest you give up computing, because PC hardware doesnt make
> > your grade. BTW the general open promise bugs *dont* include data
> > corruption so I suspect it may be your h/w thats hosed.
> 
> Mine, and the original poster? And the "me too?" I understood the author
> to say that the new board needed a driver change, and if that's the case
> why not hold off the driver until he gets to it? Nobody if faulting him
> for lack of time, but it seems not to work.
> 
> Guess it must be my hardware, two boards, two systems, corruption only on
> the drives on the new... hell with it, obviously if you don't have the
> problem the original poster and I must be clueless whiners.
> 
> I'll drop this discussion and scrap the board, restores cost more than
> controllers :-(
> 
> -- 
> bill davidsen <davidsen@tmr.com>
>   CTO, TMR Associates, Inc
> Doing interesting things with little computers since 1979.
> 

Andre Hedrick
LAD Storage Consulting Group

