Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269673AbRHYQbu>; Sat, 25 Aug 2001 12:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269752AbRHYQbk>; Sat, 25 Aug 2001 12:31:40 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:1805 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S269673AbRHYQbe>; Sat, 25 Aug 2001 12:31:34 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Russell King <rmk@arm.linux.org.uk>, Nicolas Pitre <nico@cam.org>
Subject: Re: What version of the kernel fixes these VM issues?
Date: Sat, 25 Aug 2001 18:38:19 +0200
X-Mailer: KMail [version 1.3.1]
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20010824222924Z16116-32383+1243@humbolt.nl.linux.org> <Pine.LNX.4.33.0108241940280.25240-100000@xanadu.home> <20010825090959.A2561@flint.arm.linux.org.uk>
In-Reply-To: <20010825090959.A2561@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010825163138Z16182-32383+1333@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 25, 2001 10:09 am, Russell King wrote:
> On Fri, Aug 24, 2001 at 11:00:05PM -0400, Nicolas Pitre wrote:
> > 6 page tables cached
> 
> Although this won't help the basic problem, there could me as much as 100K
> cached in those page tables.  I wonder if we could hook the pgt cache into
> the VM cache shrinking, so we can free most, if not all of this cache
> (rather than it being in the idle loop only).
> 
> I'll look into it, produce a patch, but I'm not a VM hacker.

You know what a pte is so you're a VM hacker ;-)

--
Daniel
