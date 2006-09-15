Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751437AbWIONmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbWIONmY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 09:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbWIONmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 09:42:24 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:12709 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751437AbWIONmX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 09:42:23 -0400
Date: Fri, 15 Sep 2006 15:41:03 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Paul Mundt <lethal@linux-sh.org>
cc: Karim Yaghmour <karim@opersys.com>, Jes Sorensen <jes@sgi.com>,
       Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
In-Reply-To: <20060915132052.GA7843@localhost.usen.ad.jp>
Message-ID: <Pine.LNX.4.64.0609151535030.6761@scrub.home>
References: <20060914112718.GA7065@elte.hu> <Pine.LNX.4.64.0609141537120.6762@scrub.home>
 <20060914135548.GA24393@elte.hu> <Pine.LNX.4.64.0609141623570.6761@scrub.home>
 <20060914171320.GB1105@elte.hu> <Pine.LNX.4.64.0609141935080.6761@scrub.home>
 <20060914181557.GA22469@elte.hu> <4509A54C.1050905@opersys.com>
 <yq08xkleb9h.fsf@jaguar.mkp.net> <450A9EC9.9080307@opersys.com>
 <20060915132052.GA7843@localhost.usen.ad.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 15 Sep 2006, Paul Mundt wrote:

> On Fri, Sep 15, 2006 at 08:38:33AM -0400, Karim Yaghmour wrote:
> > If you'd care to read through the thread you'd notice I've demonstrated
> > time and again that those static trace points we're mostly interested
> > in a never-changing. Lest something fundamentally changes with the
> > kernel, there will always be a scheduling change; etc. This
> > "instrumentation is evil" mantra is only substantiated if you view
> > it from the point of view of someone who's only used it to debug code.
> > Yet, and I repeat this again, instrumentation for in-source debugging
> > is but a corner case of instrumentation in general.
> > 
> I didn't get the "instrumentation is evil" mantra from this thread,
> rather "static tracepoints are good, so long as someone else is
> maintaining them". The issue comes down to who ends up maintaining the
> trace points,

The claim that these tracepoints would be maintainance burden is pretty 
much unproven so far. The static tracepoint haters just assume the kernel 
will be littered with thousands of unrelated tracepoints, where a good 
tracepoint would only document what already happens in that function, so 
that the tracepoint would be far from something obscure, which only few 
people could understand and maintain.

bye, Roman
