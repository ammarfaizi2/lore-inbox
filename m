Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267619AbTBVAoX>; Fri, 21 Feb 2003 19:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267749AbTBVAoX>; Fri, 21 Feb 2003 19:44:23 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:11225 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267619AbTBVAoW>; Fri, 21 Feb 2003 19:44:22 -0500
Date: Fri, 21 Feb 2003 16:44:13 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Larry McVoy <lm@bitmover.com>, Hanna Linder <hannal@us.ibm.com>
cc: lse-tech@lists.sf.et, linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <306820000.1045874653@flay>
In-Reply-To: <20030222001618.GA19700@work.bitmover.com>
References: <96700000.1045871294@w-hlinder>
 <20030222001618.GA19700@work.bitmover.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ben is right.  I think IBM and the other big iron companies would be
> far better served looking at what they have done with running multiple
> instances of Linux on one big machine, like the 390 work.  Figure out
> how to use that model to scale up.  There is simply not a big enough
> market to justify shoveling lots of scaling stuff in for huge machines
> that only a handful of people can afford.  That's the same path which
> has sunk all the workstation companies, they all have bloated OS's and
> Linux runs circles around them.

In your humble opinion.

Unfortunately, as I've pointed out to you before, this doesn't work in
practice. Workloads may not be easily divisible amongst machines, and
you're just pushing all the complex problems out for every userspace
app to solve itself, instead of fixing it once in the kernel.

The fact that you were never able to do this before doesn't mean it's
impossible, it just means that you failed.

> In terms of the money and in terms of installed seats, the small Linux
> machines out number the 4 or more CPU SMP machines easily 10,000:1.
> And with the embedded market being one of the few real money makers
> for Linux, there will be huge pushback from those companies against
> changes which increase memory footprint.

And the profit margin on the big machines will outpace the smaller 
machines by a similar ratio, inverted. The high-end space is where most 
of the money is made by the Linux distros, by selling products like SLES
or Advanced Server to people who can afford to pay for it.

M.

