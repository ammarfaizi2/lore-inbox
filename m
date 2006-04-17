Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbWDQXue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWDQXue (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 19:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932069AbWDQXue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 19:50:34 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:13232 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932068AbWDQXud (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 19:50:33 -0400
Date: Mon, 17 Apr 2006 16:48:52 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Steven Rostedt <rostedt@goodmis.org>
cc: Ravikiran G Thirumalai <kiran@scalex86.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
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
       paulus@samba.org, linux390@de.ibm.com, davem@davemloft.net
Subject: Re: [PATCH 00/05] robust per_cpu allocation for modules
In-Reply-To: <Pine.LNX.4.58.0604171936040.24264@gandalf.stny.rr.com>
Message-ID: <Pine.LNX.4.64.0604171647330.31773@schroedinger.engr.sgi.com>
References: <1145049535.1336.128.camel@localhost.localdomain>
 <4440855A.7040203@yahoo.com.au> <Pine.LNX.4.64.0604170953390.29732@schroedinger.engr.sgi.com>
 <20060417220238.GD3945@localhost.localdomain> <Pine.LNX.4.58.0604171936040.24264@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Apr 2006, Steven Rostedt wrote:

> So now we can focus on a better solution.

Could you have a look at Kiran's work?

Maybe one result of your work could be that the existing indirection
for alloc_percpu could be avoided?
