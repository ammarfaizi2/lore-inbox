Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271431AbRIFQnQ>; Thu, 6 Sep 2001 12:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271421AbRIFQnG>; Thu, 6 Sep 2001 12:43:06 -0400
Received: from spike.porcupine.org ([168.100.189.2]:33801 "EHLO
	spike.porcupine.org") by vger.kernel.org with ESMTP
	id <S271431AbRIFQmy>; Thu, 6 Sep 2001 12:42:54 -0400
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip alias
 bug 2.4.9 and 2.2.19]
In-Reply-To: <20010906203854.A23109@castle.nmd.msu.ru> "from Andrey Savochkin
 at Sep 6, 2001 08:38:54 pm"
To: Andrey Savochkin <saw@saw.sw.com.sg>
Date: Thu, 6 Sep 2001 12:43:14 -0400 (EDT)
Cc: Matthias Andree <matthias.andree@gmx.de>,
        Wietse Venema <wietse@porcupine.org>, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org
X-Time-Zone: USA EST, 6 hours behind central European time
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20010906164314.74F68BC06C@spike.porcupine.org>
From: wietse@porcupine.org (Wietse Venema)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Savochkin:
> You are missing my point.
> Local addresses do not exist at all, there are no such entity in the physical
> world.

Allow me to be the first to welcome you to the real world. Welcome!

An SMTP MTA is required to correctly recognize user@[ip.address]
as local.  That's the rules, like it or not. These address forms
are actually being used, like it or not.

It also is desirable for an MTA to treat clients on local subnets
different than strangers that happen to be on the same class A,
like it or not.  Failure to do so can make one end up on black
lists, like it or not.

So, I repeat my request for *constructive* contributions on how to
deal with these issues on Linux, when everything already works
correctly for all other Postfix-supported systems, like it or not.

	Wietse
