Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287518AbSALVtQ>; Sat, 12 Jan 2002 16:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287516AbSALVtG>; Sat, 12 Jan 2002 16:49:06 -0500
Received: from svr3.applink.net ([206.50.88.3]:61707 "EHLO svr3.applink.net")
	by vger.kernel.org with ESMTP id <S287256AbSALVs5>;
	Sat, 12 Jan 2002 16:48:57 -0500
Message-Id: <200201122148.g0CLmfSr008317@svr3.applink.net>
Content-Type: text/plain; charset=US-ASCII
From: Timothy Covell <timothy.covell@ashavan.org>
Reply-To: timothy.covell@ashavan.org
To: "Prof. Brand " <brand@jupiter.cs.uni-dortmund.de>,
        timothy.covell@ashavan.org
Subject: Re: strange kernel message when hacking the NIC driver
Date: Sat, 12 Jan 2002 15:44:50 -0600
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200201122137.g0CLbDR26750@jupiter.cs.uni-dortmund.de>
In-Reply-To: <200201122137.g0CLbDR26750@jupiter.cs.uni-dortmund.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 12 January 2002 15:37, Prof. Brand  wrote:
> Timothy Covell <timothy.covell@ashavan.org> said:
> > On Friday 11 January 2002 06:07, David S. Miller wrote:
> > >    From: Timothy Covell <timothy.covell@ashavan.org>
> > >    Date: Fri, 11 Jan 2002 05:55:20 -0600
> > >
> > >    Let me clarify what I said earlier.  You cannot have
> > >    identical MAC addresses on two different NICs.
> > >
> > > There is nothing illegal about that at all.  As long at
> > > the NICs live on different subnets, it is perfectly fine.
> > > In fact this is pretty common on Sun machines.
> >
> > True.  I was assuming that the context of the post was
> > that the NICs were on the same network link.
>
> This is not the typical setup...
>
> > Solaris _defaults_ to using the MAC address from the
> > primary (hostname) NIC for the rest of them.
>
> Sun sets the MAC from the machine ID on all network interfaces by
> default. Not Solaris, AFAIU it is done by the PROM.
>
> >                                              IMHO, this
> > is a really stupid thing to do, and  I disable it tout de suite
> > when given a choice.   Of course, if you like it, then
> > why don't you try to convince Linus to change his mind
> > about it?
>
> Why should DaveM convince Linus to get Sun to change their mind on NIC
> setup?

You have it backwards.  If you all seem to like the Sun way of doing things,
then Linus should change Linux to do likewise.

>
> Especially if it works just fine for 99.95% of Suns, and has the bonus that
> you can track each machine by a _single_ MAC, even if you change NICs or
> add more?

If you are already keeping a MAC <--> Host table, then it's not very hard to
expand it to keep track of other NICs.   That is, of course, if you care about
tracking your inventory.   

-- 
timothy.covell@ashavan.org.
