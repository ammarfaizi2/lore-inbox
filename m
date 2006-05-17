Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbWEQP5B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWEQP5B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 11:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWEQP5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 11:57:01 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:11495 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750756AbWEQP5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 11:57:00 -0400
Date: Wed, 17 May 2006 11:56:27 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Christoph Lameter <clameter@sgi.com>
cc: LKML <linux-kernel@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Paul Mackerras <paulus@samba.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@suse.de>,
       Martin Mares <mj@atrey.karlin.mff.cuni.cz>, bjornw@axis.com,
       schwidefsky@de.ibm.com, benedict.gaster@superh.com, lethal@linux-sh.org,
       Chris Zankel <chris@zankel.net>, Marc Gauthier <marc@tensilica.com>,
       Joe Taylor <joe@tensilica.com>,
       David Mosberger-Tang <davidm@hpl.hp.com>, rth@twiddle.net,
       spyro@f2s.com, starvik@axis.com, tony.luck@intel.com,
       linux-ia64@vger.kernel.org, ralf@linux-mips.org,
       linux-mips@linux-mips.org, grundler@parisc-linux.org,
       parisc-linux@parisc-linux.org, linuxppc-dev@ozlabs.org,
       linux390@de.ibm.com, davem@davemloft.net, arnd@arndb.de,
       kenneth.w.chen@intel.com, sam@ravnborg.org, kiran@scalex86.org
Subject: Re: [RFC PATCH 00/09] robust VM per_cpu variables
In-Reply-To: <Pine.LNX.4.64.0605170846190.13337@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0605171152190.15798@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0605170547490.8408@gandalf.stny.rr.com>
 <Pine.LNX.4.64.0605170744360.13021@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0605171104100.13160@gandalf.stny.rr.com>
 <Pine.LNX.4.64.0605170846190.13337@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2006, Christoph Lameter wrote:

> On Wed, 17 May 2006, Steven Rostedt wrote:
>
> > OK, now I'm just rambling. I don't know,  have any other ideas on making
> > this more robust?  Or is this all in vain, and I should spend my evenings
> > walking around this beautiful town of Karlsruhe ;)
>
> Well I'd like to see a comprehensive solution including a fix for the
> problems with allocper_cpu() allocations (allocper_cpu has to allocate
> memory for potential processors... which could be a lot on
> some types of systems and its allocated somewhere not on the nodes of the
> processor since they may not yet be online).

OK, now you're beyond what I'm working with ;)  No hot plug CPUs for me.
Well, at least not yet!

>
> Wish I could be back home in Germany to talk a walk with you. Are you
> coming to the OLS?

I'm just here on business. Will be back home in the States on Saturday.

Yep, I'll be at OLS.  Hopefully we can get a group together to do some
brainstorming.

Thanks,

-- Steve

