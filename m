Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267962AbTBVXKX>; Sat, 22 Feb 2003 18:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267963AbTBVXKX>; Sat, 22 Feb 2003 18:10:23 -0500
Received: from bitmover.com ([192.132.92.2]:39340 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S267962AbTBVXKW>;
	Sat, 22 Feb 2003 18:10:22 -0500
Date: Sat, 22 Feb 2003 15:20:29 -0800
From: Larry McVoy <lm@bitmover.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Mark Hahn <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030222232029.GB31268@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Mark Hahn <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0302221648010.2686-100000@coffee.psychology.mcmaster.ca> <1370000.1045955447@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1370000.1045955447@[10.10.2.4]>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We would never try to propose such a change, and never have. 
> Name a scalability change that's hurt the performance of UP by 5%.
> There isn't one.

This is *exactly* the reasoning that every OS marketing weenie has used
for the last 20 years to justify their "feature" of the week.

The road to slow bloated code is paved one cache miss at a time.  You
may quote me on that.  In fact, print it out and put it above your
monitor and look at it every day.  One cache miss at a time.  How much
does one cache miss add to any benchmark?  .001%?  Less.  

But your pet features didn't slow the system down.  Nope, they just made
the cache smaller, which you didn't notice because whatever artificial
benchmark you ran didn't happen to need the whole cache.  

You need to understand that system resources belong to the user.  Not the
kernel.  The goal is to have all of the kernel code running under any 
load be less than 1% of the CPU.  Your 5% number up there would pretty 
much double the amount of time we spend in the kernel for most workloads.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
