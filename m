Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751641AbWIOPSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641AbWIOPSW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 11:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751642AbWIOPSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 11:18:22 -0400
Received: from opersys.com ([64.40.108.71]:1800 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S1751637AbWIOPSV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 11:18:21 -0400
Message-ID: <450AC69C.70302@opersys.com>
Date: Fri, 15 Sep 2006 11:28:28 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: tglx@linutronix.de
CC: Paul Mundt <lethal@linux-sh.org>, Jes Sorensen <jes@sgi.com>,
       Roman Zippel <zippel@linux-m68k.org>, Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060914181557.GA22469@elte.hu> <4509A54C.1050905@opersys.com>	 <yq08xkleb9h.fsf@jaguar.mkp.net> <450A9EC9.9080307@opersys.com>	 <20060915132052.GA7843@localhost.usen.ad.jp>	 <Pine.LNX.4.64.0609151535030.6761@scrub.home>	 <20060915135709.GB8723@localhost.usen.ad.jp> <450AB5F9.8040501@opersys.com>	 <450AB506.30802@sgi.com> <450AB957.2050206@opersys.com>	 <20060915142836.GA9288@localhost.usen.ad.jp> <450ABE08.2060107@opersys.com> <1158332447.5724.423.camel@localhost.localdomain>
In-Reply-To: <1158332447.5724.423.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thomas Gleixner wrote:
> You just made it clear, that your solution was and still is targeted on
> one single user group.

And that was part of my point. Every time I got in a debate on lkml
regarding ltt, there were crowds screaming in horror at the possibility
of trace points everywhere.

> Nobody is opposing instrumentation per se, we just need to figure out a
> good solution suitable for endusers, kernel developers, debug
> fetishists ... without splattering ten different tracers all across the
> kernel source.

I agree entirely.

> The way to a solid kernel instrumentation is definitely not by pushing a
> single purpose solution in, which we have to _maintain_ for a long time
> without being convinced that it is the _best_ technical solution we can
> have right now.

I think we're in full agreement. A solid kernel instrumentation mechanism
is exactly what is needed. The whole point of posting the ltt stuff on
the lkml is exactly to get the best technical solution. The ltt developers
are more than happy to take suggestions as to how to achieve this.

Karim
