Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271465AbUJVQg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271465AbUJVQg5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 12:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271466AbUJVQg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 12:36:57 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:8201 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S271465AbUJVQgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 12:36:50 -0400
Message-ID: <417939F1.8090601@techsource.com>
Date: Fri, 22 Oct 2004 12:48:49 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Greg Buchholz <linux@sleepingsquirrel.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
References: <82D5E38355314D46AF3015FF55F6955802F83515@CORPMAIL3> <4177FF47.5040005@techsource.com> <20041021213600.GB675@sleepingsquirrel.org> <41783ADB.8030802@techsource.com> <20041021234053.GC675@sleepingsquirrel.org>
In-Reply-To: <20041021234053.GC675@sleepingsquirrel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Greg Buchholz wrote:
> Timothy Miller wrote:
> 
>>How are you getting these prices for the FPGAs?  Maybe they have changed 
>>since I last checked.  And what volumes are you expecting here?
> 
> 
> I took the pricing from a xilinx press release found here (for 250k
> qty)...
> 
> http://www.xilinx.com/prs_rls/silicon_spart/03142s3_pricing.htm
> 
> "Pricing and Availability: The 3S50, 3S200, and 3S400 Spartan-3 devices
> with 50,000, 200,000, and 400,000 system gates respectively, are
> available for less than $6.50*. The 3S1000 Spartan-3 device with 1
> million system gates is also available for under $12.00*. The entire
> Spartan-3 family will be available in volume production in early 2004
> from distributors worldwide, or direct from Xilinx at
> www.xilinx.com/spartan/"

Unless we have a major Linux hardware vendor partnering with us, I 
cannot feel confident that we could make those sorts of volumes.  Think 
of the out-lay just to purchase the initial stock.  And then by the time 
we sell 1/10 of them, the price will have dropped and we'll have a stock 
of chips worth less than we paid for them.

Bleh.  I feel very stupid when it comes to the business and economics of 
this.  I'm an engineer with what I think is a cool idea, but right now 
I'm working on crash-coursing myself in all the business of it.  Before 
long, the real marketing people here will get interested, but I have to 
prove some things to them first.

It won't be long, though.  The Slashdot buzz has everyone in the company 
coming by my office to distract me from writing this LKML post.  :)

>>I'm a pretty good engineer, and I have to tell you that it took me 2
>>years before I got a real "grok"-level feel for chip design.  When
>>programming C, there are just certain things you "know" about how the
>>code you write is going to translate into machine code.  The same
>>thing is true for designing hardware.  It took me about a week to
>>learn Verilog syntax really well (even got some of the concepts that
>>trip people up like "natural size"), but it took me a LONG time to
>>really get GOOD at it.
> 
> 
>     I'll bet it also took you two years from the time you were first
> exposed to programming to the time when you could look at a chunk of C
> code and know about how many assembly instructions would be generated
> ;-).

No.  Maybe 15 to 20 for that.  :)

>  
> 
>>There's this general rule of thumb that if you write your C code more
>>compactly, you often get a faster result.  Not always true, but more
>>often than not.  Well, the exact opposite is true for HDL.  The more
>>elaborate and specific you are, the better your results are, because
>>the synthesizer has more information about what it is that you really
>>want.
> 
> 
>     C is to assembly as Verilog is to schematic entry.  Which means C
> and Verilog are both increadibly low level languages.  Some day most
> digital circuits will be designed with higher level language like Lava
> (http://www.xilinx.com/labs/lava/) or Ruby HDL
> (http://web.comlab.ox.ac.uk/oucl/work/geraint.jones/ruby/).  (Or at
> least that's what I'm hoping for).  And maybe a project like this will
> bring that day sooner.

My point is that understanding assembly does not in any way 
automatically translate into an understanding of logic circuitry.  In 
fact, I'd have to say that I had to break as many habits as I developed 
when learning to be a chip designer.

> 
>>I see programming and chip design as two very different things.  One
>>is sequential, and the other has everything going on in parallel.
> 
>     
>     Nah, two sides of the same coin.  Think sum of products vs. product
> of sums, functional programming languages vs. imperative programming
> languages, time domain vs. frequency domain, analytical methods vs.
> numerical methods, ying vs. yang...

I'll have to talk to my wife about this.  She has a law degree and is 
working on an information science degree right now.  I find that I 
compartmentalize my understanding of things, so when I explain technical 
things to her, she has trouble understanding them sometimes, not because 
she can't grok it, but because I make assumptions of dichotomies which 
are completely arbitrary and make no sense from the outside.

For instance, we had a frustrating discussion where she seemed to be 
assuming that there was no difference, abstractly, between an HTML 
document and a Java program.  I always thought of programs and documents 
as two different things.  Eventually, she got it through my thick skull 
that if you see an executable file and an HTML document and a JPG file 
as nothing more than symbols that have to be interpreted by something 
else, then they really ARE the same thing.

Here's the kicker that caused so much confusion:  The idea that there 
could be one level or multiple levels of interpretation seemed so 
trivially obvious to her that it never occurred to her to mention the 
idea.  :)

Now, it's obvious enough to me, but I never thought of it as so 
PAINFULLY obvious.  When you look at things this way, you start to see 
that, for example, a CPU is nothing more than "middleware" between 
machine code and physical reality.  :)

Anyhow, the reason for that long discussion is because I see chip design 
and software programming as generally incompatible mindsets.  Sure, one 
can certainly help you to learn the other, but many methodologies that 
apply to one would be horrible to apply to the other.  Learning Verilog 
syntax and then trying to apply software programming concepts to it will 
get you absolutely nowhere.  Perhaps she can help me to see it your way.  :)

> 
>>This company is used to being a niche player.  The profit margins are
>>higher in vertical markets.  This commodity graphics board idea is
>>going to be hard enough sell as it is.
> 
> 
>    Yeah, I've mostly drifted into the dream world of what I'd like to
> see, not necessarily what is practical.  But you've got to admit, the
> board with 8 FPGAs would be one hell of cool hack.

It would be a cool thing to play with, and I'm not taking it off the 
table, but I have to start out at least LOOKING like I'm doing something 
practical.  :)


