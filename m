Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287513AbSALVhp>; Sat, 12 Jan 2002 16:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287545AbSALVhf>; Sat, 12 Jan 2002 16:37:35 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:9413 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S287518AbSALVhU>; Sat, 12 Jan 2002 16:37:20 -0500
Message-Id: <200201122137.g0CLbDR26750@jupiter.cs.uni-dortmund.de>
To: timothy.covell@ashavan.org
cc: linux-kernel@vger.kernel.org
Subject: Re: strange kernel message when hacking the NIC driver 
In-Reply-To: Message from Timothy Covell <timothy.covell@ashavan.org> 
   of "Fri, 11 Jan 2002 06:20:42 CST." <200201111224.g0BCOYSr001179@svr3.applink.net> 
Date: Sat, 12 Jan 2002 22:37:13 +0100
From: "Prof. Brand " <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Covell <timothy.covell@ashavan.org> said:
> On Friday 11 January 2002 06:07, David S. Miller wrote:
> >    From: Timothy Covell <timothy.covell@ashavan.org>
> >    Date: Fri, 11 Jan 2002 05:55:20 -0600
> >
> >    Let me clarify what I said earlier.  You cannot have
> >    identical MAC addresses on two different NICs.
> >
> > There is nothing illegal about that at all.  As long at
> > the NICs live on different subnets, it is perfectly fine.
> > In fact this is pretty common on Sun machines.
> 
> True.  I was assuming that the context of the post was
> that the NICs were on the same network link.

This is not the typical setup...

> Solaris _defaults_ to using the MAC address from the 
> primary (hostname) NIC for the rest of them.

Sun sets the MAC from the machine ID on all network interfaces by
default. Not Solaris, AFAIU it is done by the PROM.

>                                              IMHO, this 
> is a really stupid thing to do, and  I disable it tout de suite
> when given a choice.   Of course, if you like it, then
> why don't you try to convince Linus to change his mind 
> about it?

Why should DaveM convince Linus to get Sun to change their mind on NIC
setup?

Especially if it works just fine for 99.95% of Suns, and has the bonus that
you can track each machine by a _single_ MAC, even if you change NICs or
add more?
-- 
Horst von Brand			     http://counter.li.org # 22616
