Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbTIHIca (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 04:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262084AbTIHIca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 04:32:30 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:55908 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262086AbTIHIc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 04:32:28 -0400
To: Larry McVoy <lm@bitmover.com>
Cc: Stephen Satchell <list@fluent2.pyramid.net>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, "Brown, Len" <len.brown@intel.com>,
       Giuliano Pochini <pochini@shiny.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scaling noise
References: <105370000.1062622139@flay> <20030903212119.GX4306@holomorphy.com>
	<115070000.1062624541@flay> <20030903215135.GY4306@holomorphy.com>
	<116940000.1062625566@flay> <20030904010653.GD5227@work.bitmover.com>
	<m11xusnvqc.fsf@ebiederm.dsl.xmission.com>
	<20030907230729.GA19380@work.bitmover.com>
	<m1wuckma9z.fsf@ebiederm.dsl.xmission.com>
	<5.2.1.1.0.20030907214214.01c25ac8@fluent2.pyramid.net>
	<20030908052524.GA1990@work.bitmover.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 08 Sep 2003 02:32:03 -0600
In-Reply-To: <20030908052524.GA1990@work.bitmover.com>
Message-ID: <m1oexvn0jg.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy <lm@bitmover.com> writes:

> On Sun, Sep 07, 2003 at 09:47:58PM -0700, Stephen Satchell wrote:
> > At 05:57 PM 9/7/2003 -0700, Larry McVoy wrote:
> > >That's not "a machine" that's ~1150 machines on a network.  This business
> > >of describing a bunch of boxes on a network as "a machine" is nonsense.
> > 
> > Then you haven't been keeping up with Open-source projects, or the 
> > literature.  
> 
> Err, I'm in that literature, dig a little, you'll find me.  I'm quite
> familiar with clustering technology.  While it is great that people are
> wiring up lots of machines and running MPI or whatever on them, they've
> been doing that for decades.  It's only a recent thing that they started
> calling that "a machine".  That's marketing, and it's fine marketing,
> but a bunch of machines, a network, and a library does not a machine make.

Oh so you need cache coherency to make it a machine.  That being the only
difference between that and a NUMA box.

Although I will state that there is a lot more that goes into such
a system than a network, and a library.  At least there is a lot more
that goes into the manageable version of one.

> Not to me it doesn't.  I want to be able to exec a proces and have it land
> anywhere on the "machine", any CPU, I want controlling tty semantics,
> if I have 2300 processes in one process group then when I hit ^Z they
> had all better stop.  Etc.

Oh wait none of that comes with cache coherency.  So the difference
cannot be cache coherency.

> A collection of machines that work together is called a network of 
> machines, it's not one machine, it's a bunch of them.  There's nothing
> wrong with getting a lot of use out of a pile of networked machines,
> it's a great thing.  But it's no more a machine than the internet is
> a machine.

Cool so the SGI Ultrix is not a machine.  Nor is the SMP box over in
my lab.  They are separate machines wired together with a network, and
so I better start calling them a network of machines.

As far as I can tell which pile of hardware to call a machine
is a difference that makes no difference.  Marketing as you put it.

The only practical difference would seem to be what kind of problems
you think are worth solving for a collection of hardware.  By calling
it a single machine I am saying I think it is worth solving the single
system image problem.  By refusing to call it a machine you seem to
think it is a class of hardware which is not worth paying attention to.

I do think it is a class of hardware that is worth solving the hard
problems for.  And I will continue to call that pile of hardware a
machine until I give up on that. 

I admit the hard problems have not yet been solved but the solutions
are coming.

Eric
