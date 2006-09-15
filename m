Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbWIOWW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbWIOWW2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 18:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbWIOWW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 18:22:28 -0400
Received: from opersys.com ([64.40.108.71]:46092 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S932157AbWIOWW2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 18:22:28 -0400
Message-ID: <450B29FB.7000301@opersys.com>
Date: Fri, 15 Sep 2006 18:32:27 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: "Jose R. Santos" <jrs@us.ibm.com>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
       tglx@linutronix.de, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <450AB957.2050206@opersys.com> <20060915142836.GA9288@localhost.usen.ad.jp> <450ABE08.2060107@opersys.com> <1158332447.5724.423.camel@localhost.localdomain> <20060915111644.c857b2cf.akpm@osdl.org> <20060915181907.GB17581@elte.hu> <Pine.LNX.4.64.0609152111030.6761@scrub.home> <20060915200559.GB30459@elte.hu> <20060915202233.GA23318@Krystal> <450B164B.7090404@us.ibm.com> <20060915220345.GC12789@elte.hu>
In-Reply-To: <20060915220345.GC12789@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar wrote:
> that is not true at all. Yes, an INT3 based kprobe might be expensive if 
> +0.5 usecs per tracepoint (on a 1GHz CPU) is an issue to you - but that 
> is "only" an implementation detail, not a conceptual property. 
> Especially considering that help (djprobes) is on the way. And in the 

djprobes has been "on the way" for some time now. Why don't you at
least have the intellectual honesty to use the same rules you've
repeatedly used against ltt elsewhere in this thread -- i.e. what
it does today is what it is, and what it does today isn't worth
bragging about. But that would be too much to ask of you Ingo,
wouldn't it?

But, sarcasm aside, even if this mechanism existed it still wouldn't
resolve the need for static markup. It would just make djprobe a
likelier candidate for tools that cannot currently rely on kprobes.

> NOTE: i still accept the temporary (or non-temporary) introduction of 
> static markers, to help dynamic tracing. But my expectation is that 
> these markers will be less intrusive than static tracepoints, and a lot 
> more flexible.

Chalk one up for nice endorsement and another for arbitrary distinction.

Karim

