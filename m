Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287256AbSACFpt>; Thu, 3 Jan 2002 00:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288210AbSACFpn>; Thu, 3 Jan 2002 00:45:43 -0500
Received: from dsl-213-023-043-254.arcor-ip.net ([213.23.43.254]:41480 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S287256AbSACFpb>;
	Thu, 3 Jan 2002 00:45:31 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrew Morton <akpm@zip.com.au>, "M. Edward Borasky" <znmeb@aracnet.com>
Subject: Re: kswapd etc hogging machine
Date: Thu, 3 Jan 2002 06:48:47 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Art Hays <art@lsr.nei.nih.gov>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0201022214230.8413-100000@lsr-linux> <HBEHIIBBKKNOBLMPKCBBAECPEFAA.znmeb@aracnet.com> <3C33E8EA.FAF8E337@zip.com.au>
In-Reply-To: <3C33E8EA.FAF8E337@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16M0kC-00012Q-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 3, 2002 06:15 am, Andrew Morton wrote:
> And we, the kernel developers, should hang our heads over this.  A
> vendor-released, stable kernel is performing terribly with such a
> simple workload.  One year after the release of 2.4.0!

To be fair, in the year leading up to 2.4.0 much energy was expended on 
getting the bugs out of the unified and heaviliy threaded page+buffer 
cache[1], at the expense of work on the memory manager, so 2001 ended up 
being like a whole new kernel cycle.  Anyway, the saving grace is that 2.2 
managed to metamorphose from ugly duckling to... quite a nice duck, with 
almost all the features of 2.4 from the user's point of view.  So everybody 
has something to run.

With 20 20 hindsight, the VM work could have been managed better but I don't 
see why anybody's head needs to be hung.  It was a bumpy road, we had to 
change a few tires, but we got to the other side of the mountain.

--
Daniel

[1] According to Matt Dillon's interview today, FreeBSD went through the same 
pain unifying their caches, and they have yet to seriously tackle the SMP 
issues.
