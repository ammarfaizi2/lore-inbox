Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267806AbTBVARR>; Fri, 21 Feb 2003 19:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267807AbTBVARQ>; Fri, 21 Feb 2003 19:17:16 -0500
Received: from holomorphy.com ([66.224.33.161]:55462 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267806AbTBVARQ>;
	Fri, 21 Feb 2003 19:17:16 -0500
Date: Fri, 21 Feb 2003 16:25:55 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Larry McVoy <lm@work.bitmover.com>, Hanna Linder <hannal@us.ibm.com>,
       lse-tech@lists.sf.et, linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030222002555.GC10411@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Larry McVoy <lm@work.bitmover.com>,
	Hanna Linder <hannal@us.ibm.com>, lse-tech@lists.sf.et,
	linux-kernel@vger.kernel.org
References: <96700000.1045871294@w-hlinder> <20030222001618.GA19700@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030222001618.GA19700@work.bitmover.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2003 at 04:16:18PM -0800, Larry McVoy wrote:
> Ben is right.  I think IBM and the other big iron companies would be
> far better served looking at what they have done with running multiple
> instances of Linux on one big machine, like the 390 work.  Figure out
> how to use that model to scale up.  There is simply not a big enough
> market to justify shoveling lots of scaling stuff in for huge machines
> that only a handful of people can afford.  That's the same path which
> has sunk all the workstation companies, they all have bloated OS's and
> Linux runs circles around them.

Scalability done properly should not degrade performance on smaller
machines, Pee Cees, or even microscopic organisms.


On Fri, Feb 21, 2003 at 04:16:18PM -0800, Larry McVoy wrote:
> In terms of the money and in terms of installed seats, the small Linux
> machines out number the 4 or more CPU SMP machines easily 10,000:1.
> And with the embedded market being one of the few real money makers
> for Linux, there will be huge pushback from those companies against
> changes which increase memory footprint.

There's quite a bit of commonality with large x86 highmem there, as
the highmem crew is extremely concerned about the kernel's memory
footprint and is looking to trim kernel memory overhead from every
aspect of its operation they can. Reducing kernel memory footprint
is a crucial part of scalability, in both scaling down to the low end
and scaling up to highmem. =)


-- wli
