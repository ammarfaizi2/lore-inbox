Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285424AbSADNDi>; Fri, 4 Jan 2002 08:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285552AbSADND2>; Fri, 4 Jan 2002 08:03:28 -0500
Received: from ns.ithnet.com ([217.64.64.10]:61705 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S285424AbSADNDZ>;
	Fri, 4 Jan 2002 08:03:25 -0500
Date: Fri, 4 Jan 2002 14:03:21 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Ken Brownfield <brownfld@irridia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-Id: <20020104140321.51cb8bf0.skraw@ithnet.com>
In-Reply-To: <20020103232601.B12884@asooo.flowerfire.com>
In-Reply-To: <20020103142301.C4759@asooo.flowerfire.com>
	<200201040019.BAA30736@webserver.ithnet.com>
	<20020103232601.B12884@asooo.flowerfire.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jan 2002 23:26:01 -0600
Ken Brownfield <brownfld@irridia.com> wrote:

> On Fri, Jan 04, 2002 at 01:19:28AM +0100, Stephan von Krawczynski wrote:
> | > A) VM has major issues                                              
> |                                                                       
> | On all boxes I run currently (all 1GB or below RAM), I cannot find    
> | _major_ issues.                                                       
> 
> Yeah, I'm seeing it primarily with 1-4GB, though I have very few <1GB
> machines in production.

Ok. It would be really nice to know if the -aa patches do any good at your
configs. Andrea has possibly done something on the issue. But let me take this
chance to state an open word: last time Andrea talked about his personal
hardware I couldn't really believe it - because it was so ridiculously small. I
wonder if anyone at SuSE management _does_ actually read this list and think
about how someone can do a good job without good equipment. If you really want
to do something groundbreaking about highmem you have to have a _box_. A box
_somewhere_ in the world or a patch for highmem-in-lowmem is not really the
same thing. Even Schumacher wouldn't have won formula one by sitting inside a
Fiat Uno with a patched speedometer.

> but I
> do think the mindset behind the kernel needs to at least partially break
> free of the grip of UP desktops, at least to the point of fixing issues
> like I'm mentioning.
> 
> Not critical for me; but high-profile on lkml.

You are right.

> [...]
> | > C) IO-APIC code that requires noapic on any and all SMP             
> | >   machines that I've ever run on.                                   
> |                                                                       
> | I am currently running 5 Asus CUV4X-D based SMP boxes all with apic   
> | _on_, amongst  which are squids, sql servers, workstation type setups 
> | (2 my very own).                                                      
> 
> Do they have *sustained* heavy hit/IRQ/IO load?  For example, sending
> 25Mbit and >1,000 connections/s of sustained small images traffic
> through khttpd will kill 2.4 (slow loss of timer and eventual total
> freeze) in a couple of hours.  Trivially reproducable for me on SMP with
> any amount of memory.  On HP, Tyan, Intel, Asus... etc.

Hm, I have about 24GB of NFS traffic every day, which may be too less. What
exactly are you seeing in this case (logfiles etc.)?

> It's not that the kernel is bad, it's that there are specific things
> that shouldn't be forgotten because of a "the kernel is good"
> evaluation.

Hopefully nobody does this here, I don't.

> Like I said, I suspect that most people with machines in lower-load
> environments don't have these issues, but "number of people effected" is
> only one metric to judge the importance of an issue.

The number of people is not really interesting for me, as the boxes get bigger
every day it is only a matter of time to see more people with lots of GB (as an
example).

> Of course, I'm not biased or anything. ;-)

How could you ? ;-))

Regards,
Stephan

