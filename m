Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270679AbUJUOnv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270679AbUJUOnv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 10:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270727AbUJUOjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 10:39:17 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:59142 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S270718AbUJUOfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 10:35:01 -0400
Message-ID: <4177CBD5.2030003@techsource.com>
Date: Thu, 21 Oct 2004 10:46:45 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: David Lang <david.lang@digitalinsight.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
References: <4176E08B.2050706@techsource.com> <Pine.LNX.4.60.0410201521310.17443@dlang.diginsite.com>
In-Reply-To: <Pine.LNX.4.60.0410201521310.17443@dlang.diginsite.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



David Lang wrote:
> On Wed, 20 Oct 2004, Timothy Miller wrote:
> 
>> Sure, SOME companies release specs so that we can develop open source 
>> drivers, but those cards tend to be prohibitively expensive, slower 
>> than their cheaper counterparts from ATI or nVidia...
> 
> 
> Tim, I think this is the key problem. with the current ATI/nVidia cards 
> beign in the $50 range (with other cards on the market for as low as 
> $30) are you really going to be able to come up with a card that's price 
> competitive? (completely ignoring the performance question)

I've just had a discussion with our senior ASIC designer, and we came up 
with ball-park numbers for the cost of a first run of boards in a 
quantity of 1000.

FPGA              Anywhere from $50 to $500, depending on logic area
Power regulators  $10 - $40
RAM               $24 (for 128 megs)
DAC               $2
DVI xmit          $8
PCB               $7
Connectors, etc.  $4
PROM chips        $5

Given the sum of that, whatever it turns out to be, for it to be worth 
while in quantities that small, we'd have to make roughly that much 
again in profit (assuming development cost and development time are 
something like proportional).

If the quantities were a lot higher, then prices go down for everything. 
  For instance, we can take the FPGA design and have the vendor turn it 
directly into an ASIC.  What you get is something that requires 20% the 
chip area and runs twice as fast, and the per-chip cost is a lot lower, 
but there's an NRE of $100K, and then you can't reprogram the chip. 
(Maybe there should be 'fixed' and 'reprogrammable' versions of the 
product.)

> 
> as for your other question of if an open approach could be viable (after 
> all nobody does it today so doesn't that proove it isn't)
> 
> this is where there is a significant disagreement. the Linux folks think 
> that such openess would be very viable and the companies are just 
> pursuing a legacy approach, but the companies are scared to open things 
> up becouse they don't believe that they would remain viable.

Right.  There are two problems that arise here.  One is that another 
company might try to pirate our design (it's an FPGA bitfile on a PROM, 
after-all), and although that is illegal, litigation is something to be 
avoided.  The second problem is that another, much larger, company would 
look at all of our published materials, produce something compatible, 
and then undercut us out of this particular market.  While I can 
certainly appreciate the capitalist value of that sort of competition, I 
am in the situation where that competition would simply kill my project 
instantly.

I like to pick on Stallman and his excessive idealism, but in this case, 
I want his utopian ideal to work.  I want to have a piece of hardware 
which is totally compatible with the ideal.  The problem is that, in 
some markets, the ideal may be completely unrealistic.

> since nobody has done this yet (for video cards anyeay) there is no 
> proof one way or the other.

Well, if Tech Source management decides that this project isn't worth 
the effort, you'll have a small piece of circumstantial evidence that 
leans toward "it's not viable".  I personally want to find a way to make 
it work.

To the open source community, this is a golden opportunity to directly 
influence the design of a piece of hardware which fits their ideals. 
For me personally, this is a golden opportunity to work on a project 
from which I'll derive an immense amount of enjoyment.  For both 
accounts, I'm desperate to find a way to make it work.  :)

