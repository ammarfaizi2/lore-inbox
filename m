Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263092AbRFND34>; Wed, 13 Jun 2001 23:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263935AbRFND3q>; Wed, 13 Jun 2001 23:29:46 -0400
Received: from chac.inf.utfsm.cl ([200.1.19.54]:52490 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S263092AbRFND3j>;
	Wed, 13 Jun 2001 23:29:39 -0400
Message-Id: <200106140155.f5E1ts5X003318@sleipnir.valparaiso.cl>
To: "Daniel" <ddickman@nyc.rr.com>
cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Subject: Re: obsolete code must die 
In-Reply-To: Message from "Daniel" <ddickman@nyc.rr.com> 
   of "Wed, 13 Jun 2001 20:44:11 -0400." <01a401c0f46b$20b932e0$480e6c42@almlba4sy7xn6x> 
Date: Wed, 13 Jun 2001 21:55:54 -0400
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Daniel" <ddickman@nyc.rr.com> said:

[...]

> So without further ado here're the features I want to get rid of:
> 
> i386, i486
> The Pentium processor has been around since 1995. Support for these older
> processors should go so we can focus on optimizations for the pentium and
> better processors.

How much does this contribute? I guess the _truly_ i[34]86 dependent code
is a few hundred lines, if that much. Besides, you would probably be
surprised at the number of those machines in use.

[...]

> ISA bus, MCA bus, EISA bus
> PCI is the defacto standard. Get rid of CONFIG_BLK_DEV_ISAPNP,
> CONFIG_ISAPNP, etc

Just too bad that 2 out of my 4 machines at home are ISA only, this one is
ISA/PCI; and of the servers at work a lowly P/155 (just ISA) is doing
useful work as the connection point for modems.


[...]

> parallel/serial/game ports
> More controversial to remove this, since they are *still* in pretty wide
> use -- but USB and IEEE 1394 are the way to go. No ifs ands or buts.

No non-paralell printers in sight for me. Some 2 dozen printers in all.

[...]

> I really think doing a clean up is worthwhile. Maybe while looking for stuff
> to clean up we'll even be able to better comment the existing code. Any
> other features people would like to get rid of? Any comments or suggestions?
> I'd love to start a good discussion about this going so please send me your
> 2 cents.

Try it, and come back with patches.
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
