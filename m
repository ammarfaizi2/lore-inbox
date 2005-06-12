Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261270AbVFLXE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbVFLXE6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 19:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbVFLXE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 19:04:58 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:19184 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261270AbVFLXE5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 19:04:57 -0400
Subject: Re: PREEMPT_RT vs ADEOS: the numbers, part 1
From: Sven-Thorsten Dietrich <sdietrich@mvista.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Karim Yaghmour <karim@opersys.com>, Ingo Molnar <mingo@elte.hu>,
       Kristian Benoit <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       paulmck@us.ibm.com, bhuey@lnxw.com, tglx@linutronix.de,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, dwalker@mvista.com, hch@infradead.org, akpm@osdl.org,
       rpm@xenomai.org
In-Reply-To: <20050612222011.GG5796@g5.random>
References: <42AA6A6B.5040907@opersys.com> <20050611191448.GA24152@elte.hu>
	 <42AB662B.4010104@opersys.com>  <20050612222011.GG5796@g5.random>
Content-Type: text/plain
Date: Sun, 12 Jun 2005 16:03:41 -0700
Message-Id: <1118617421.12889.71.camel@sdietrich-xp.vilm.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-06-13 at 00:20 +0200, Andrea Arcangeli wrote:
> On Sat, Jun 11, 2005 at 06:31:07PM -0400, Karim Yaghmour wrote:
> > The logger used two TSC values. One prior to shooting the interrupt to the
> > target, and one when receiving the response. Responding to an interrupt
> 
> Real life RT apps would run the second rdtsc in user space and not
> kernel space, right?
> 
> And thanks for your benchmarking efforts!

Real-life RT apps are not benchmarks!

There is not requirement for them to run in user space or in kernel
space.

The choice is left to the application designer.


