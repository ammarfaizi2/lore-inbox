Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129036AbQKFIC4>; Mon, 6 Nov 2000 03:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130249AbQKFICp>; Mon, 6 Nov 2000 03:02:45 -0500
Received: from waste.org ([209.173.204.2]:33586 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S129036AbQKFICf>;
	Mon, 6 Nov 2000 03:02:35 -0500
Date: Mon, 6 Nov 2000 02:02:31 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: "David S. Miller" <davem@redhat.com>
cc: barryn@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] document ECN in 2.4 Configure.help
In-Reply-To: <200011060730.XAA31897@pizda.ninka.net>
Message-ID: <Pine.LNX.4.10.10011060148300.8248-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Nov 2000, David S. Miller wrote:

>    Date: 	Mon, 6 Nov 2000 01:34:14 -0600 (CST)
>    From: Oliver Xymoron <oxymoron@waste.org>
> 
>    I'm still not sure why it's been decided not to do fallback or how
>    this whole situation is any different from path MTU discovery.
> 
> We don't use fallbacks for path MTU discovery (I assume you are
> referring to black hole detection, we don't do it, never have never
> will), you have to explicitly turn path-mtu discovery off.  It's been
> on by default for 3 or 4 years now :-)

Hmmm, for some reason I thought we had it, but it's been a non-issue for a
long time. The ECN thing hasn't bitten me yet either, happily.

So the question then becomes what is the process whereby we decide that
Linux will follow standards that are known to silently break things in a
large part of the real world. We explicitly don't do this with a user's
hardware, and I think we have other work-arounds for network
interoperability. How big and how badly does something have to break
before it becomes something we work around?

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
