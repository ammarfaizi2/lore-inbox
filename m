Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbVLLW3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbVLLW3o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 17:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbVLLW3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 17:29:44 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:63619 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932128AbVLLW3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 17:29:43 -0500
Subject: Re: 2.6.15-rc5-rt1 will not compile (was Re: 2.6.14-rt15: cannot
	build with !PREEMPT_RT)
From: Lee Revell <rlrevell@joe-job.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: david singleton <dsingleton@mvista.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1134426179.24145.15.camel@localhost.localdomain>
References: <1133031912.5904.12.camel@mindpipe>
	 <1133034406.32542.308.camel@tglx.tec.linutronix.de>
	 <20051127123052.GA22807@elte.hu> <1133141224.4909.1.camel@mindpipe>
	 <20051128114852.GA3391@elte.hu> <1133189789.5228.7.camel@mindpipe>
	 <20051128160052.GA29540@elte.hu> <1133217651.4678.2.camel@mindpipe>
	 <1133230103.5640.0.camel@mindpipe> <20051129072922.GA21696@elte.hu>
	 <20051129093231.GA5028@elte.hu>  <1134090316.11053.3.camel@mindpipe>
	 <1134174330.18432.46.camel@mindpipe>  <1134409469.15074.1.camel@mindpipe>
	 <1134424143.24145.6.camel@localhost.localdomain>
	 <1134425688.17058.5.camel@mindpipe>
	 <1134426179.24145.15.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 12 Dec 2005 17:31:50 -0500
Message-Id: <1134426711.17058.10.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-12 at 17:22 -0500, Steven Rostedt wrote:
> On Mon, 2005-12-12 at 17:14 -0500, Lee Revell wrote:
> 
> > 
> > The patch had no effect.
> 
> The patch should work for krfoley though.  His errors where the same
> that I had for i386.  I also have it working under x86_64.
> > 
> > In fact x86-64 does not set CONFIG_RWSEM_XCHGADD_ALGORITHM so this test
> > in include/linux/rwsem.h causes asm/rwsem.h to be included which does
> > not exist on x86-64:
> 
> Yeah OK, you have a different problem.  Did you post your .config?  You
> can send it privately to me if you haven't already posted it.

Yes I posted the .config earlier in the thread.  Let me know if you want
me to resend it to you.

Lee

