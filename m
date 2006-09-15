Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751689AbWIOUE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751689AbWIOUE3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 16:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751690AbWIOUE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 16:04:29 -0400
Received: from www.osadl.org ([213.239.205.134]:15845 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751689AbWIOUE1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 16:04:27 -0400
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Frank Ch. Eigler" <fche@redhat.com>, karim@opersys.com,
       Tim Bird <tim.bird@am.sony.com>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
In-Reply-To: <Pine.LNX.4.64.0609152046350.6761@scrub.home>
References: <Pine.LNX.4.64.0609151339190.6761@scrub.home>
	 <1158323938.29932.23.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0609151425180.6761@scrub.home>
	 <1158327696.29932.29.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0609151523050.6761@scrub.home>
	 <1158331277.29932.66.camel@localhost.localdomain>
	 <450ABA2A.9060406@opersys.com>
	 <1158332324.29932.82.camel@localhost.localdomain>
	 <y0mmz91f46q.fsf@ton.toronto.redhat.com>
	 <1158345108.29932.120.camel@localhost.localdomain>
	 <20060915181208.GA17581@elte.hu>
	 <Pine.LNX.4.64.0609152046350.6761@scrub.home>
Content-Type: text/plain
Date: Fri, 15 Sep 2006 22:05:16 +0200
Message-Id: <1158350716.5724.488.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-15 at 21:10 +0200, Roman Zippel wrote:
> > 
> > this is being worked on actively: there's the "djprobes" patchset, which 
> > includes a simplified disassembler to analyze common target code and can 
> > thus insert much faster, call-a-trampoline-function based tracepoints 
> > that are just as fast as (or faster than) compile-time, static 
> > tracepoints.
> 
> Who is going to implement this for every arch?
> Is this now the official party line that only archs, which implement all 
> of this, can make use of efficient tracing?

In the reverse you are enforcing an ugly - but available for all archs -
solution due to the fact that there is nobody interested enough to
implement it ?

If there is no interest to do that, then this arch can probably live w/o
instrumentation for the next decade too.

	tglx


