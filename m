Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279842AbRKVPdc>; Thu, 22 Nov 2001 10:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279903AbRKVPdN>; Thu, 22 Nov 2001 10:33:13 -0500
Received: from butterblume.comunit.net ([192.76.134.57]:5646 "EHLO
	butterblume.comunit.net") by vger.kernel.org with ESMTP
	id <S279902AbRKVPdG>; Thu, 22 Nov 2001 10:33:06 -0500
Date: Thu, 22 Nov 2001 16:33:03 +0100 (CET)
From: Sven Koch <haegar@sdinet.de>
X-X-Sender: haegar@space.comunit.de
To: Ishak Hartono <lotus@upnaway.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: anyone got the same problem with DIGITAL 21143 network card ?
In-Reply-To: <001201c1735c$9ac546d0$0b01a8c0@lotus>
Message-ID: <Pine.LNX.4.40.0111221625540.9632-100000@space.comunit.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Nov 2001, Ishak Hartono wrote:

> I tried to compile 2.4.14 and successfully detect the digital 21143 network
> card, however, i can't ping out
>
> this is just a curiosity, because it works with my 2.2.17 kernel
>
> the reason why i didn't move to 2.4.x yet because i got this problem with
> 2.4.5 as well and gave it a try again on 2.4.14 kernel
>
> anyone know what should i check in the system  other than blaming on the
> kernel ?

Same problem here with a p100 and two dec-tulip-cards and 2.4.14.

Driver loads without problems, ifconfig works too, routes are set - even
the 10baseT-link is detected (it switches to 10base2 when I remove the
cable, and back to 10baseT after reattaching)

But the kernel sees nothing on the wire (tcpdump), and nothing it sends is
seen by the other machines.

Dropped Packet/Overrun count (don't remember which of the two) keeps
rising for every packet it tries to send.


The woody-default-kernel (2.2.20?) works without problems.

I will lookup the exact card-type and error-symptomes this night, when I'm
back home. (And possibly try 2.4.15-preNewest, but kernel-compiling on
this to-be-router takes a long time)

c'ya
sven

-- 

The Internet treats censorship as a routing problem, and routes around it.
(John Gilmore on http://www.cygnus.com/~gnu/)

