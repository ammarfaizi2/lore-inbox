Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271102AbUJUXpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271102AbUJUXpb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 19:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271020AbUJUXmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 19:42:22 -0400
Received: from bdsl.66.14.157.209.gte.net ([66.14.157.209]:52717 "EHLO
	greg.sparky.org") by vger.kernel.org with ESMTP id S271110AbUJUXlZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 19:41:25 -0400
Date: Thu, 21 Oct 2004 16:40:53 -0700
From: Greg Buchholz <linux@sleepingsquirrel.org>
To: Timothy Miller <miller@techsource.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
Message-ID: <20041021234053.GC675@sleepingsquirrel.org>
References: <82D5E38355314D46AF3015FF55F6955802F83515@CORPMAIL3> <4177FF47.5040005@techsource.com> <20041021213600.GB675@sleepingsquirrel.org> <41783ADB.8030802@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41783ADB.8030802@techsource.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller wrote:
> 
> How are you getting these prices for the FPGAs?  Maybe they have changed 
> since I last checked.  And what volumes are you expecting here?

I took the pricing from a xilinx press release found here (for 250k
qty)...

http://www.xilinx.com/prs_rls/silicon_spart/03142s3_pricing.htm

"Pricing and Availability: The 3S50, 3S200, and 3S400 Spartan-3 devices
with 50,000, 200,000, and 400,000 system gates respectively, are
available for less than $6.50*. The 3S1000 Spartan-3 device with 1
million system gates is also available for under $12.00*. The entire
Spartan-3 family will be available in volume production in early 2004
from distributors worldwide, or direct from Xilinx at
www.xilinx.com/spartan/"

> I'm a pretty good engineer, and I have to tell you that it took me 2
> years before I got a real "grok"-level feel for chip design.  When
> programming C, there are just certain things you "know" about how the
> code you write is going to translate into machine code.  The same
> thing is true for designing hardware.  It took me about a week to
> learn Verilog syntax really well (even got some of the concepts that
> trip people up like "natural size"), but it took me a LONG time to
> really get GOOD at it.

    I'll bet it also took you two years from the time you were first
exposed to programming to the time when you could look at a chunk of C
code and know about how many assembly instructions would be generated
;-).
 
> There's this general rule of thumb that if you write your C code more
> compactly, you often get a faster result.  Not always true, but more
> often than not.  Well, the exact opposite is true for HDL.  The more
> elaborate and specific you are, the better your results are, because
> the synthesizer has more information about what it is that you really
> want.

    C is to assembly as Verilog is to schematic entry.  Which means C
and Verilog are both increadibly low level languages.  Some day most
digital circuits will be designed with higher level language like Lava
(http://www.xilinx.com/labs/lava/) or Ruby HDL
(http://web.comlab.ox.ac.uk/oucl/work/geraint.jones/ruby/).  (Or at
least that's what I'm hoping for).  And maybe a project like this will
bring that day sooner.

> I see programming and chip design as two very different things.  One
> is sequential, and the other has everything going on in parallel.
    
    Nah, two sides of the same coin.  Think sum of products vs. product
of sums, functional programming languages vs. imperative programming
languages, time domain vs. frequency domain, analytical methods vs.
numerical methods, ying vs. yang...

> This company is used to being a niche player.  The profit margins are
> higher in vertical markets.  This commodity graphics board idea is
> going to be hard enough sell as it is.

   Yeah, I've mostly drifted into the dream world of what I'd like to
see, not necessarily what is practical.  But you've got to admit, the
board with 8 FPGAs would be one hell of cool hack.


Greg Buchholz

