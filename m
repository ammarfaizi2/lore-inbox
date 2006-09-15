Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbWIOPAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbWIOPAF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 11:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932066AbWIOPAB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 11:00:01 -0400
Received: from www.osadl.org ([213.239.205.134]:55008 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932065AbWIOPAA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 11:00:00 -0400
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: karim@opersys.com
Cc: Paul Mundt <lethal@linux-sh.org>, Jes Sorensen <jes@sgi.com>,
       Roman Zippel <zippel@linux-m68k.org>, Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
In-Reply-To: <450ABE08.2060107@opersys.com>
References: <20060914181557.GA22469@elte.hu> <4509A54C.1050905@opersys.com>
	 <yq08xkleb9h.fsf@jaguar.mkp.net> <450A9EC9.9080307@opersys.com>
	 <20060915132052.GA7843@localhost.usen.ad.jp>
	 <Pine.LNX.4.64.0609151535030.6761@scrub.home>
	 <20060915135709.GB8723@localhost.usen.ad.jp> <450AB5F9.8040501@opersys.com>
	 <450AB506.30802@sgi.com> <450AB957.2050206@opersys.com>
	 <20060915142836.GA9288@localhost.usen.ad.jp> <450ABE08.2060107@opersys.com>
Content-Type: text/plain
Date: Fri, 15 Sep 2006 17:00:47 +0200
Message-Id: <1158332447.5724.423.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-15 at 10:51 -0400, Karim Yaghmour wrote:
> And what I did is "b". I wasn't going to defend anybody else's
> choice of tracepoints. Those who were using ltt for its designated
> purpose -- allowing normal users and developers to get an accurate
> view of the behavior of their system -- were very happy with it.
> 
> You want to know who was unhappy with using it: kernel developers.
> It just wasn't geared for them. Which goes back to my earlier
> arguments ...

What do you want to prove with this rant ? Simply the fact that your
view of tracing is not matching the view of others. Nothing else.

You just made it clear, that your solution was and still is targeted on
one single user group.

Nobody is opposing instrumentation per se, we just need to figure out a
good solution suitable for endusers, kernel developers, debug
fetishists ... without splattering ten different tracers all across the
kernel source.

The way to a solid kernel instrumentation is definitely not by pushing a
single purpose solution in, which we have to _maintain_ for a long time
without being convinced that it is the _best_ technical solution we can
have right now.

	tglx


