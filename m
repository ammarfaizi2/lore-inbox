Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbWIOTqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbWIOTqz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 15:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751603AbWIOTqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 15:46:55 -0400
Received: from opersys.com ([64.40.108.71]:48650 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S1751590AbWIOTqy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 15:46:54 -0400
Message-ID: <450B0585.5070700@opersys.com>
Date: Fri, 15 Sep 2006 15:56:53 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: tglx@linutronix.de
CC: Andrew Morton <akpm@osdl.org>, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>, Roman Zippel <zippel@linux-m68k.org>,
       Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060914181557.GA22469@elte.hu> <4509A54C.1050905@opersys.com>	 <yq08xkleb9h.fsf@jaguar.mkp.net> <450A9EC9.9080307@opersys.com>	 <20060915132052.GA7843@localhost.usen.ad.jp>	 <Pine.LNX.4.64.0609151535030.6761@scrub.home>	 <20060915135709.GB8723@localhost.usen.ad.jp> <450AB5F9.8040501@opersys.com>	 <450AB506.30802@sgi.com> <450AB957.2050206@opersys.com>	 <20060915142836.GA9288@localhost.usen.ad.jp> <450ABE08.2060107@opersys.com>	 <1158332447.5724.423.camel@localhost.localdomain>	 <20060915111644.c857b2cf.akpm@osdl.org> <1158348954.5724.481.camel@localhost.localdomain>
In-Reply-To: <1158348954.5724.481.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thomas Gleixner wrote:
> One thing which is much more important IMHO is the availablity of
> _USEFUL_ postprocessing tools to give users a real value of
> instrumentation. This is a much more complex task than this whole kernel
> instrumentation business. This also includes the ability to coordinate
> user space _and_ kernel space instrumentation, which is necessary to
> analyse complex kernel / application code interactions. 

And of course the usefulness of such postprocessing tools is gated
by the ability of users to use them on _any_ kernel they get their
hands on. Up to this point, this has not been for *any* of the
existing toolsets, simply because they require the user to either
recompile his kernel or modify his probe points to match his kernel.
Until users can actually do without either of these steps (which is
only possible with static markup) then the development teams of
the various projects will continue having to invest resources
chasing the kernel.

We don't need separate popstprocessing tool teams. The only reasons
there are separate project teams is because managers in key
positions made the decision that they'd rather break from existing
projects which had had little success mainlining and instead use
their corporate bodyweight to pressure/seduce kernel developers
working for them into pushing their new great which-aboslutely-
has-nothing-to-do-with-this-ltt-crap-(no,no, we actually agree
with you kernel developers that this is crap, this is why we're
developing this new amazing thing). That's the truth plain and
simple.

When I started involving myself in Linux development a decade ago,
I honestly did not think I'd ever see this kind of stuff happen,
but, hey, that's life.

Karim

