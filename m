Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965122AbWIQVkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965122AbWIQVkw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 17:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965123AbWIQVkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 17:40:52 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:12427 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965122AbWIQVkv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 17:40:51 -0400
Date: Sun, 17 Sep 2006 23:32:51 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Roman Zippel <zippel@linux-m68k.org>, Thomas Gleixner <tglx@linutronix.de>,
       karim@opersys.com, Andrew Morton <akpm@osdl.org>,
       Paul Mundt <lethal@linux-sh.org>, Jes Sorensen <jes@sgi.com>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060917213251.GC2145@elte.hu>
References: <Pine.LNX.4.64.0609161831270.6761@scrub.home> <20060916230031.GB20180@elte.hu> <Pine.LNX.4.64.0609170310580.6761@scrub.home> <20060917084207.GA8738@elte.hu> <Pine.LNX.4.64.0609171627400.6761@scrub.home> <20060917152527.GC20225@elte.hu> <Pine.LNX.4.64.0609171744570.6761@scrub.home> <450D7EF0.3020805@yahoo.com.au> <Pine.LNX.4.64.0609171918430.6761@scrub.home> <450D8C58.5000506@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <450D8C58.5000506@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4996]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> As an aside, there are quite a number of different types of tracing 
> things (mostly static, compile out) in the kernel. Everything from 
> blktrace to various userspace notifiers to lots of /proc/stuff could 
> be considered a type of static event tracing. I don't know what my 
> point is other than all these big, disjoint frameworks trying to be 
> pushed into the kernel. Are there any plans for working some things 
> together, or is that somebody else's problem?

AFAIK Jens has indicated interest in seeing experiments that would try 
to replace BKLTRACE with dynamic tracepoints, so it's being worked on.

but yes, that would be the general idea: to turn all existing ad-hoc 
tracing/debugging points in the kernel into static SystemTap markers or 
SystemTap scripts.

	Ingo
