Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265814AbUA2Qtd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 11:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266240AbUA2Qtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 11:49:33 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:63750 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S265814AbUA2Qt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 11:49:29 -0500
Message-ID: <40193A67.7080308@techsource.com>
Date: Thu, 29 Jan 2004 11:52:55 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>
CC: chakkerz@optusnet.com.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Crazy idea:  Design open-source graphics chip
References: <4017F2C0.4020001@techsource.com> <200401291211.05461.chakkerz@optusnet.com.au> <40193136.4070607@techsource.com> <200401291629.i0TGTN7S001406@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200401291629.i0TGTN7S001406@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



John Bradford wrote:
>>The real question we have to ask ourselves is, what would be the market 
>>demand for a graphics card that is 3 generations behind the state of the 
>>art and over-priced, the only advantage being that it's a 100% open 
>>architecture?
> 
> 
> Err, well there are always the server and embedded markets, if the
> device was cheap enough.

Ah, but it won't be.  Low-volume ASICs are expensive.  The chip itself 
would probably be around $150, not counting $100k NRE.  Then you have to 
pay for the board, make up for the NRE, and make some profit to make it 
worth while.  How much are YOU willing to pay?

> 
> 
>>I don't have $100k to have it fabricated, so we have to goad some 
>>company into doing it for us, and given the volumes, they'll have to 
>>charge way more than it's worth if you compare its capabilities against 
>>ATI et al.
>>
>>I've got some great ideas for how to do this chip, but they're frankly 
>>nothing revolutionary.  The obvious test bed is an FPGA.  That imposes 
>>serious limitations on what kind of logic utilization and performance we 
>>can get.  The ASIC version can be clocked faster, but we dare not put in 
>>untested logic.  (And we can't afford the tools necessary to do the 
>>proper simulation.)
> 
> 
> WHAT!?  You are making the project out to be several orders of
> magnitude more difficult and expensive than it is.
> 
> Did you know that you can generate a 625-line TV signal with little
> more hardware than a Z80 CPU?  Some 8-bits actually did that.

Certainly.  But when you can get perfectly good open-source drivers for 
an ATI Rage 128 and the board for $15 from a Taiwanese manufacturer, 
who's going to want what you're describing?

The thing you have to keep in mind is that in order for this open arch 
board to get developed, someone has to be willing to invest in 
fabricating it, and that means it has to be somewhat competitive and a 
significant performer.

 From the mouth of someone who has done a graphics ASIC and numerous 
FPGA designs also in graphics and who has worked on graphics boards in 
air traffic control, medical, and workstation console markets and who 
has written X-server modules for Number 9 i128, Matrox G450, Permidia 2 
and 3, Radeon 7500 and 9000, my own graphics chip, probably a number of 
chips I've forgotten AND who has been very performance and cost 
conscious the whole time:  It is MORE complicated than I make it sound.

That doesn't mean it's not doable.  :)

> 
> 
>>So, the big question:  How many units a year would be sold for an 
>>underpowered, over-priced graphics card that just happens to be 100% 
>>open and 100% supported?
> 
> 
> Quite a few.  Think of the TV-connected embedded appliance market, for
> example.  Displaying a static menu of choices isn't exactly very
> demanding.

This sort of thing is ALREADY available with open-source drivers.

Whatever we design is going to be EXPENSIVE.  So, regardless of the fact 
that an ATI All-in-Wonder Radeon 9000 is over-powered for job you 
describe, that board will be cheaper than what we could produce.


Because of certain invariant costs, there is a performance point below 
which it is not worth it.  Because of non-invariant costs, there is a 
performance above which it is not worth it.  There may or not be a point 
where the compromize makes it worth doing.


Now, this all assumes that it's completely a hobbyist project.  If we 
were to design something that was, in principle, a good performer, but 
we couldn't simulate, debug, and fabricate it, we MIGHT be able to 
convince some companies to do that FOR us.  And they might even be able 
to enhance it in ways that would make it compete on performance.

But it's still going to be expensive.

