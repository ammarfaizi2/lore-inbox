Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267914AbTBVUwL>; Sat, 22 Feb 2003 15:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267915AbTBVUwL>; Sat, 22 Feb 2003 15:52:11 -0500
Received: from franka.aracnet.com ([216.99.193.44]:47557 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267914AbTBVUwK>; Sat, 22 Feb 2003 15:52:10 -0500
Date: Sat, 22 Feb 2003 13:02:12 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Larry McVoy <lm@bitmover.com>
cc: Mark Hahn <hahn@physics.mcmaster.ca>, "David S. Miller" <davem@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <2080000.1045947731@[10.10.2.4]>
In-Reply-To: <20030222195642.GI1407@work.bitmover.com>
References: <Pine.LNX.4.44.0302221417120.2686-100000@coffee.psychology.mcmaster.ca> <1510000.1045942974@[10.10.2.4]> <20030222195642.GI1407@work.bitmover.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Interesting. Given the profit margins involved, I bet they still
>> make more money on servers than desktops and notebooks combined
>> (the annual report doesn't seem to list that). And that's before 
>> you take account of the "linux weighting" on top of that ...
> 
> Err, here's a news flash.  Dell has just one server with more than
> 4 CPUS and it tops out at 8.  Everything else is clusters.  And they
> call any machine that doesn't have a head a server, they have servers
> starting $299.  Yeah, that's right, $299.
> 
> http://www.dell.com/us/en/bsd/products/series_pedge_servers.htm
> 
> How much do you want to bet that more than 95% of their server revenue
> comes from 4CPU or less boxes?  I wouldn't be surprised if it is more
> like 99.5%.  And you can configure yourself a pretty nice quad xeon box
> for $25K.  Yeah, there is some profit in there but nowhere near the huge
> margins you are counting on to make your case.

OK, so now you've slid from talking about PCs to 2-way to 4-way ...
perhaps because your original arguement was fatally flawed.

The work we're doing on scalablity has big impacts on 4-way systems
as well as the high end. We're also simultaneously dramatically improving
stability for smaller SMP machines by finding reproducing races in 
5 minutes that smaller machines might hit once every year or so, and 
running high-stress workloads that thrash the hell out of various 
subsystems exposing bugs.

Some applications work well on clusters, which will give them cheaper 
hardware, at the expense of a lot more complexity in userspace ... 
depending on the scale of the system, that's a tradeoff that might go 
either way. 

For applications that don't work well on clusters, you have no real
choice but to go with the high-end systems. I'd like to see Linux
across the board, as would many others.

You don't believe we can make it scale without screwing up the low end,
I do believe we can do that. Time will tell ... Linus et al are not 
stupid ... we're not going to be able to submit stuff that screwed up
the low-end, even if we wanted to.

M.



