Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263206AbTEBXl1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 19:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263208AbTEBXl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 19:41:27 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:28648 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S263206AbTEBXl0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 19:41:26 -0400
Date: Fri, 02 May 2003 16:55:15 -0700
From: Hanna Linder <hannal@us.ibm.com>
Reply-To: Hanna Linder <hannal@us.ibm.com>
To: lse-tech@lists.sourceforge.net
cc: linux-kernel@vger.kernel.org
Subject: Minutes from May 2 Call
Message-ID: <55010000.1051919715@w-hlinder>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Bill -

Able to get his hands on a NUMA-Q with 64 GB of memory (or rather,
put it together) and it worked. The I/O throughput went up as measured
by dbench on a UP. On the 64GB verified there were no out of memory
conditions or leaks or crashes. He did the performance testing on a
smaller system as the 64 gig was only available for a short time.

He asked for any feedback at all... Has anyone looked at the code?
Do people like the idea? hate the idea?

Tony Luck mentioned that it was similar to what was done
on VAX and it was a good thing then and a good thing now.

Bill said it is alot like that done on the VAX (with BSD?)

Tony asked about systems that support multiple page sizes,
could it be extended to work (ie-IA64)? Bill said that it would 
require a second tlb entry size notion among other things. So it
would be possible but difficult. Bill said he thought about
ia64 at first but people didnt seem very excited about it.
Tony said people might be more excited about it in the future
and Bill did some clever things (partial pages) with pgcl
that might make it possible to work with multiple page sizes.

Bill also has it running on his laptop where he is doing some
fo the testing. He agrees the state of the code now is pretty
stinky and has to go back around to clean up things he did just
to get it working.

The rate of bug fixing has decreased. Linus expressed interest
on Hugh's patch in the 2.4 era but hasnt commented on Bill's
work. Andrew has expressed some interest but hasnt made any
moves to include it. 

Hanna asked Bill when he thinks it will be stable and mergeable.
Bill said part of the problem is he doesnt have access to all
the drivers or a cross-system guarantee without any other
people running it.

John asked if running it on systems with 1-8MB would be worth
it. Bill said internal fragmentation could be really bad on
a system that small. But it would be interesting. So John 
may run it. Bill is desperate for feedback!

Hanna-

We decided on Wednesdays at 2pm PDT. All future meetings
will be on Wednesdays (not Fridays) at 2pm (not 9:30am).
If you are ever in doubt the web site will alwyas have
the correct time:

http://lse.sf.net/mtg







