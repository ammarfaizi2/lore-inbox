Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131678AbRCOMUt>; Thu, 15 Mar 2001 07:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131681AbRCOMUj>; Thu, 15 Mar 2001 07:20:39 -0500
Received: from linuxcare.com.au ([203.29.91.49]:16907 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S131678AbRCOMUZ>; Thu, 15 Mar 2001 07:20:25 -0500
From: Anton Blanchard <anton@linuxcare.com.au>
Date: Thu, 15 Mar 2001 23:17:22 +1100
To: Paul Larson <plars@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, cyeoh@linuxcare.com.au
Subject: Re: Kernel stress testing coverage
Message-ID: <20010315231722.A31185@linuxcare.com>
In-Reply-To: <OF50B88864.0721DA46-ON85256A09.006EE3FD@raleigh.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <OF50B88864.0721DA46-ON85256A09.006EE3FD@raleigh.ibm.com>; from plars@us.ibm.com on Thu, Mar 08, 2001 at 02:57:35PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

> Are you talking about the same posix test suite that LSB is using?  I've
> looked into that a little, but here are the two problems I'm wanting to
> address:
> 
> 1. How much of the kernel is getting hit on a run of any given test?  Even
> an approximate percentage is fine as long as I can prove it.
> 
> 2. I could run many many copies simultaneously I suppose and get some
> stress, but I'd prefer to stress individual pieces one at a time.  Those
> pieces could then be mixed together in later runs for mixed load stress.
> Additional mixed load tests will be performed with general applications
> (web servers, databases, etc) for more of a "real world" environment, but I
> want to have focused tests as well.

The POSIX tests are good for regression testing not necessarily for
stress testing, obviously both are important. The person to talk to
about this is Chris Yeoh <cyeoh@linuxcare.com.au>.

> I'm betting that there are probably a LOT of quick and dirty test programs
> that kernel hackers have written to expose a problem or thoroughly test a
> piece of the kernel that they modified.  These type of things would be
> FYI this project will be going on sourceforge very soon.  I want to have a
> little more to start out with though and finish putting together a good
> project description, testplans, etc. to post as soon as we put it on there.
> I hate it when people start projects and you don't see any good information
> about it for weeks.

Yes for example I have a set of scripts I use to test software raid,
loopback, ramdisk etc for sparc because there is a tendency for these
things to break and not get found until long afterwards.

Anton
