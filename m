Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261302AbVFMAxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbVFMAxm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 20:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVFMAxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 20:53:42 -0400
Received: from titan.genwebhost.com ([209.9.226.66]:57038 "EHLO
	titan.genwebhost.com") by vger.kernel.org with ESMTP
	id S261302AbVFMAxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 20:53:40 -0400
Date: Sun, 12 Jun 2005 17:53:17 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Sven-Thorsten Dietrich <sdietrich@mvista.com>
Cc: andrea@suse.de, karim@opersys.com, mingo@elte.hu, kbenoit@opersys.com,
       linux-kernel@vger.kernel.org, paulmck@us.ibm.com, bhuey@lnxw.com,
       tglx@linutronix.de, pmarques@grupopie.com, bruce@andrew.cmu.edu,
       nickpiggin@yahoo.com.au, ak@muc.de, dwalker@mvista.com,
       hch@infradead.org, akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT vs ADEOS: the numbers, part 1
Message-Id: <20050612175317.1fa416e6.rdunlap@xenotime.net>
In-Reply-To: <1118617421.12889.71.camel@sdietrich-xp.vilm.net>
References: <42AA6A6B.5040907@opersys.com>
	<20050611191448.GA24152@elte.hu>
	<42AB662B.4010104@opersys.com>
	<20050612222011.GG5796@g5.random>
	<1118617421.12889.71.camel@sdietrich-xp.vilm.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - titan.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Jun 2005 16:03:41 -0700 Sven-Thorsten Dietrich wrote:

| On Mon, 2005-06-13 at 00:20 +0200, Andrea Arcangeli wrote:
| > On Sat, Jun 11, 2005 at 06:31:07PM -0400, Karim Yaghmour wrote:
| > > The logger used two TSC values. One prior to shooting the interrupt to the
| > > target, and one when receiving the response. Responding to an interrupt
| > 
| > Real life RT apps would run the second rdtsc in user space and not
| > kernel space, right?
| > 
| > And thanks for your benchmarking efforts!
| 
| Real-life RT apps are not benchmarks!
| 
| There is not requirement for them to run in user space or in kernel
| space.
| 
| The choice is left to the application designer.

Wouldn't the company's attorney/lawyer/counsel be considered too?
After all, in-kernel would likely have some legal ramifications...

---
~Randy
