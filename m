Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267993AbTBWA2I>; Sat, 22 Feb 2003 19:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267994AbTBWA2I>; Sat, 22 Feb 2003 19:28:08 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:20024 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S267993AbTBWA2H>; Sat, 22 Feb 2003 19:28:07 -0500
To: Larry McVoy <lm@bitmover.com>
Cc: Hanna Linder <hannal@us.ibm.com>, lse-tech@lists.sf.et,
       linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
References: <96700000.1045871294@w-hlinder>
	<20030222001618.GA19700@work.bitmover.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 22 Feb 2003 17:37:47 -0700
In-Reply-To: <20030222001618.GA19700@work.bitmover.com>
Message-ID: <m1vfzbn86c.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy <lm@bitmover.com> writes:

> > 	Ben said none of the distros are supporting these large 
> > systems right now. Martin said UL is already starting to support
> > them. 
> 
> Ben is right.  I think IBM and the other big iron companies would be
> far better served looking at what they have done with running multiple
> instances of Linux on one big machine, like the 390 work.  Figure out
> how to use that model to scale up.  There is simply not a big enough
> market to justify shoveling lots of scaling stuff in for huge machines
> that only a handful of people can afford.  That's the same path which
> has sunk all the workstation companies, they all have bloated OS's and
> Linux runs circles around them.

Larry it isn't that Linux isn't being scaled in the way you suggest.
But for the people who really care about scalability having a single
system image is not the most important thing so making it look like
one system is secondary.

Linux clusters are currently among the top 5 supercomputers of the
world.  And there the question is how do you make 1200 machines look
like one.  And how do you handle the reliability issues.  When MTBF
becomes a predictor for how many times a week someone needs to replace
hardware the problem is very different from a simple SMP.

And there seems to be a fairly substantial market for huge machines,
for people who need high performance.  All kinds of problems are
require enormous amounts of data crunching.

So far the low hanging fruit on large clusters is still with making
the hardware and the systems actually work.  But increasingly having
a single high performance distributed filesystem is becoming
important.

But look at projects like bproc, mosix, and lustre.  Not the best
things in the world but the work is getting done.  Scalability is
easy.   The hard part is making it look like one machine when you are
done. 

Eric
