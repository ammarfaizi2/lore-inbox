Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270972AbUJUWgm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270972AbUJUWgm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 18:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271024AbUJUWdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 18:33:52 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:8461 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S270972AbUJUW2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 18:28:38 -0400
Message-ID: <41783ADB.8030802@techsource.com>
Date: Thu, 21 Oct 2004 18:40:27 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Greg Buchholz <greg@sleepingsquirrel.org>
CC: John Ripley <jripley@rioaudio.com>,
       "'Greg Buchholz'" <linux@sleepingsquirrel.org>,
       linux-kernel@vger.kernel.org
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
References: <82D5E38355314D46AF3015FF55F6955802F83515@CORPMAIL3> <4177FF47.5040005@techsource.com> <20041021213600.GB675@sleepingsquirrel.org>
In-Reply-To: <20041021213600.GB675@sleepingsquirrel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Greg Buchholz wrote:
> Timothy Miller wrote:
> 
>>Ok, I'll bite.  What you're suggesting is that instead of developing 
>>just a graphics card, I should develop a card populated with a bunch of 
>>FPGA's that's reprogrammable.  Putting aside the logic design tool issue 
>>(which may be difficult), what you'd get is a very expensive 
>>reprogrammable card with some RAM and some video output hardware.
>>
>>How much would you pay for THIS card?  $2000?
> 
> 
>    $300
> 
>  Here's a rough breakdown (FPGA $ => http://makeashorterlink.com/?F23722699
> 
>     $52 for 8 (eight!) Spartan 3/400 (XC3S400 = $6.50 @ 250k qty)
>     $30 for 256MB DRAM
>     $60 for Board, D/A, manufacturing, etc.
>    ----
>    $142 rough guesstimate hardware costs
>    $158 for software/profit

How are you getting these prices for the FPGAs?  Maybe they have changed 
since I last checked.  And what volumes are you expecting here?

Anyhow, this is helpful, also, in terms of the parts costs for the 
graphics board idea.  We need to update our prices.

> 
>>Now, the thing is, this card is SO generic that Tech Source would have 
>>very little value-add.  Say we populate it with a bunch of Spartan 3 
>>400's... well, you'd download Xilinx's WebPack, code up your design in 
>>Verilog 
> 
> 
>     Yeah, that's probably the catch, because I'd want to use gvs (GNU
> verilog/VHDL synthesis ;)

If you can get it to talk to a Xilinx, I don't care.

> 
>>(Do you want to learn chip design???  It's not like programming 
>>in C!!!), and then use our open source utility to upload your code.
> 
> 
>     Chip design isn't that much different than writing code.  Plus it
> would be a great learning experience for anyone who hasn't tried a
> hardware design language.  (Kinda like how learning lisp is an eye
> opener for most people).  Besides, I think someone would eventually
> port or create some interesting high level concurrent languages to use.
> (I could see some interesting primitives added to a language like Erlang
> or Oz to try to exploit the parallel nature of the FPGAs)

I'm a pretty good engineer, and I have to tell you that it took me 2 
years before I got a real "grok"-level feel for chip design.  When 
programming C, there are just certain things you "know" about how the 
code you write is going to translate into machine code.  The same thing 
is true for designing hardware.  It took me about a week to learn 
Verilog syntax really well (even got some of the concepts that trip 
people up like "natural size"), but it took me a LONG time to really get 
GOOD at it.

There's this general rule of thumb that if you write your C code more 
compactly, you often get a faster result.  Not always true, but more 
often than not.  Well, the exact opposite is true for HDL.  The more 
elaborate and specific you are, the better your results are, because the 
synthesizer has more information about what it is that you really want.

I see programming and chip design as two very different things.  One is 
sequential, and the other has everything going on in parallel.  Maybe 
I'm unnecessarily compartmentalizing.

Oh, and I do get the LISP thing, although if I got into it, I'd probably 
prefer Scheme, because I've seen too many examples of LISP code that 
seem to violate my understanding of what LISP is supposed to be like.  I 
can't recall the specific example, however.

> 
>>GREAT... until some other company comes along and clones it, which would 
>>be WAY too easy to do.  Now, for the users of this sort of product, it's 
>>a fine thing. 
> 
> 
>     It might not turn out to be a high profit margin business, but then
> again, I don't think slapping together "white boxes" is high margin
> either, but there doesn't seem to be a shortage of them.

This company is used to being a niche player.  The profit margins are 
higher in vertical markets.  This commodity graphics board idea is going 
to be hard enough sell as it is.

> 
>>But it becomes a pointless investment for Tech Source, 
>>which is where I work and who pays me to work on this stuff, which they 
>>wouldn't do if it's not worth it.
> 
> 
>     The hardest part would seem to be the software needed, i.e. a free
> synthesizer/mapper.  But somehow we've managed to create an entire free
> operating system.  I suppose it just takes time.  Maybe in another 5/10
> years.  Or maybe we need to think of a better way to fund open hardware
> projects.  If there were 25,000 of us who really wanted this project, we
> could pay our $300 into an escrow account ($7.5E6 total).  When the
> boards were delivered, the manufacturing company would get half the
> money, and when version 1.0 of the software was completed, they'd get
> the other half.  Surely a bank would loan money against that kind of
> collateral.  But now I'm probably rambling.

Some of these things will require a "grass roots" effort amongst open 
source developers.  I can tell you that Tech Source, among other 
companies, I'm sure, may be willing to produce hardware according to 
someone's open design.

The further away from our core business I stray, the hardware it will be 
to sell the idea to management.

