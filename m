Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751601AbWIOOnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751601AbWIOOnK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 10:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751593AbWIOOnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 10:43:10 -0400
Received: from opersys.com ([64.40.108.71]:33543 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S1751585AbWIOOnG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 10:43:06 -0400
Message-ID: <450ABE08.2060107@opersys.com>
Date: Fri, 15 Sep 2006 10:51:52 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Paul Mundt <lethal@linux-sh.org>
CC: Jes Sorensen <jes@sgi.com>, Roman Zippel <zippel@linux-m68k.org>,
       Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060914181557.GA22469@elte.hu> <4509A54C.1050905@opersys.com> <yq08xkleb9h.fsf@jaguar.mkp.net> <450A9EC9.9080307@opersys.com> <20060915132052.GA7843@localhost.usen.ad.jp> <Pine.LNX.4.64.0609151535030.6761@scrub.home> <20060915135709.GB8723@localhost.usen.ad.jp> <450AB5F9.8040501@opersys.com> <450AB506.30802@sgi.com> <450AB957.2050206@opersys.com> <20060915142836.GA9288@localhost.usen.ad.jp>
In-Reply-To: <20060915142836.GA9288@localhost.usen.ad.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Paul Mundt wrote:
> Which brings back the point of static tracepoints being entirely
> subjective. By this line of reasoning, you define for other people what
> the useful tracepoints are, and couldn't care less which points they're
> actually interested in. How exactly is this serving the need of people
> looking for instrumentation, rather than a pre-canned view of what they
> can trace? If they already have to go with their own tracepoints for the
> things they're interested in, then having a few static points
> pre-existing doesn't really buy anyone much else either, especially if
> by your own admission you're not integrating the points that people
> _are_ interested in.
> 
> I'm not indicating that you didn't do exactly what you should have in
> this situation, only that static tracepoints in general are only going
> to be a small part of the picture, and not a complete solution to most
> people on their own. Dynamic instrumentation fills the same sort of gap
> without worrying about arbitrary maintenance, so what exactly does
> shoving static instrumentation in to the kernel buy us?

And this flies in the face of all of those who, for years, have been
satisfied customers for ltt and who were more than looking forwad
for not having to depend on me to get a working traceable kernel.

The static tracepoints we maintained were *the* solution for a great
deal many people. As a maintainer I had two choices with those who
were not content:
a- Maintain their tracepoints for them -- not happening.
b- Suggest they contribute to helping getting a generic tracing
  infrastructure into the kernel and then make their case on the
  lkml as to the pertinence of their instrumentation.

And what I did is "b". I wasn't going to defend anybody else's
choice of tracepoints. Those who were using ltt for its designated
purpose -- allowing normal users and developers to get an accurate
view of the behavior of their system -- were very happy with it.

You want to know who was unhappy with using it: kernel developers.
It just wasn't geared for them. Which goes back to my earlier
arguments ...

Karim

