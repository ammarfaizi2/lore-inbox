Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266180AbRF2UwY>; Fri, 29 Jun 2001 16:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266181AbRF2UwP>; Fri, 29 Jun 2001 16:52:15 -0400
Received: from beppo.feral.com ([192.67.166.79]:53254 "EHLO beppo.feral.com")
	by vger.kernel.org with ESMTP id <S266180AbRF2UwG>;
	Fri, 29 Jun 2001 16:52:06 -0400
Date: Fri, 29 Jun 2001 13:51:19 -0700 (PDT)
From: Matthew Jacob <mjacob@feral.com>
Reply-To: <mjacob@feral.com>
To: "David S. Miller" <davem@redhat.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        christophe barbi <christophe.barbe@lineo.fr>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Qlogic Fiber Channel
In-Reply-To: <15164.59568.527480.216539@pizda.ninka.net>
Message-ID: <20010629134917.X13977-100000@wonky.feral.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Jun 2001, David S. Miller wrote:

>
> Alan Cox writes:
>  > > =46rom my point of view, this driver is sadly broken. The fun part is t=
>  > > hat
>  > > the qlogic driver is certainly based on this one too (look at the code,=
>  > >  the
>  > > drivers differs not so much).=20
>  >
>  > And if the other one is stable someone should spend the time merging the
>  > two.
>
> Actually, I think "sadly broken" depends upon your situation.
> I've been using the driver just fine on my systems here, even
> during cerberus stress testing.  So it is working perfectly fine
> for some people.

That's actually the story of Fibre Channel.

What is cerberus testing?

Try the following: try issuing a LIP every 180 seconds for 24 hours
during load with auditted pattern checkers (whether local loop or fabric
topologies). If you (and, haha, your fabric switches) survive that
without losing data or disks, then we'll begin to talk about 'fine'.

-matt


