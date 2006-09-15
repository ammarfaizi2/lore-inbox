Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751526AbWIOO2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526AbWIOO2n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 10:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751527AbWIOO2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 10:28:43 -0400
Received: from smtp.ocgnet.org ([64.20.243.3]:56283 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S1751524AbWIOO2m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 10:28:42 -0400
Date: Fri, 15 Sep 2006 23:28:36 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Karim Yaghmour <karim@opersys.com>
Cc: Jes Sorensen <jes@sgi.com>, Roman Zippel <zippel@linux-m68k.org>,
       Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060915142836.GA9288@localhost.usen.ad.jp>
References: <20060914181557.GA22469@elte.hu> <4509A54C.1050905@opersys.com> <yq08xkleb9h.fsf@jaguar.mkp.net> <450A9EC9.9080307@opersys.com> <20060915132052.GA7843@localhost.usen.ad.jp> <Pine.LNX.4.64.0609151535030.6761@scrub.home> <20060915135709.GB8723@localhost.usen.ad.jp> <450AB5F9.8040501@opersys.com> <450AB506.30802@sgi.com> <450AB957.2050206@opersys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <450AB957.2050206@opersys.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2006 at 10:31:51AM -0400, Karim Yaghmour wrote:
> Jes Sorensen wrote:
> > Because other people have tried to use LTT for additional projects,
> > but said projects haven't been integrated into LTT. In other words,
> > just because *you* haven't added those, doesn't mean someone else
> > won't try and do it later, if LTT was integrated.
> 
> Thank you. I will take it as a complement and likely laminate this
> email for your suggestion that I've acted responsibly in my
> maintenance of ltt. Boy, can you imagine what this debate would
> have looked like if I had included precisely those additional
> projects ...
> 
Which brings back the point of static tracepoints being entirely
subjective. By this line of reasoning, you define for other people what
the useful tracepoints are, and couldn't care less which points they're
actually interested in. How exactly is this serving the need of people
looking for instrumentation, rather than a pre-canned view of what they
can trace? If they already have to go with their own tracepoints for the
things they're interested in, then having a few static points
pre-existing doesn't really buy anyone much else either, especially if
by your own admission you're not integrating the points that people
_are_ interested in.

I'm not indicating that you didn't do exactly what you should have in
this situation, only that static tracepoints in general are only going
to be a small part of the picture, and not a complete solution to most
people on their own. Dynamic instrumentation fills the same sort of gap
without worrying about arbitrary maintenance, so what exactly does
shoving static instrumentation in to the kernel buy us?
