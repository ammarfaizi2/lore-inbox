Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129881AbQL2GqU>; Fri, 29 Dec 2000 01:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129901AbQL2GqK>; Fri, 29 Dec 2000 01:46:10 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:52497 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129881AbQL2Gp6>; Fri, 29 Dec 2000 01:45:58 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Repeatable 2.4.0-test13-pre4 nfsd Oops rears it head again
Date: 28 Dec 2000 22:15:17 -0800
Organization: Transmeta Corporation
Message-ID: <92ha5l$1qh$1@penguin.transmeta.com>
In-Reply-To: <20001228161126.A982@lingas.basement.bogus> <200012282159.NAA00929@pizda.ninka.net> <20001228212116.A968@lingas.basement.bogus>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20001228212116.A968@lingas.basement.bogus>,
Mike Elmore  <mike@kre8tive.org> wrote:
>
>I really need to get rid of this 8139 card.  Since
>yall are the oracle, which nice 100mbs card is fine
>hardware and is coupled with a well debugged driver?

There are always problems with some hardware, but my personal
recommendation for a card would definitely be the Intel Ethernet Pro 100
series (82557). 

Unlike the tulip cards (which are pretty good too), there aren't a
million different versions of it.  There's a few, but it's not a big
mess.  It performs well, and is stable.  It's pretty well documented
(apart from the magic extensions), and it's common. 

That said, some people have trouble even with that card.  Nobody knows
why, but at least the driver is actively maintained etc, so I still am
not nervous about recommending it. 

I bet that others will have other recommendations, but so far I have at
least personally had good luck with the eepro100.

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
