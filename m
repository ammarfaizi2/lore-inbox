Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964902AbVLJRKn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964902AbVLJRKn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 12:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964909AbVLJRKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 12:10:42 -0500
Received: from sp-260-1.net4.netcentrix.net ([4.21.254.118]:29962 "EHLO
	asmodeus.mcnaught.org") by vger.kernel.org with ESMTP
	id S964902AbVLJRKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 12:10:42 -0500
To: Bill Davidsen <davidsen@tmr.com>
Cc: Rob Landley <rob@landley.net>, Mark Lord <lkml@rtr.ca>,
       Adrian Bunk <bunk@stusta.de>, David Ranson <david@unsolicited.net>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       Matthias Andree <matthias.andree@gmx.de>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
References: <20051203135608.GJ31395@stusta.de>
	<200512051158.06882.rob@landley.net> <4395DDA8.8000003@tmr.com>
	<200512071214.26574.rob@landley.net> <439ADAF3.9040705@tmr.com>
From: Douglas McNaught <doug@mcnaught.org>
Date: Sat, 10 Dec 2005 12:05:56 -0500
In-Reply-To: <439ADAF3.9040705@tmr.com> (Bill Davidsen's message of "Sat, 10 Dec 2005 08:41:07 -0500")
Message-ID: <m2r78khogb.fsf@Douglas-McNaughts-Powerbook.local>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen <davidsen@tmr.com> writes:

> Rob Landley wrote:
>
>> Re-raising the same objections over and over again when they've
>> already been aired, considered, and rejections is called "whining".
>>
> Repeating the same information over and over until it sinks in is
> called "rote learning." The question is not if cryptoloop is perfect,
> every crypto seems to fail eventually, recently md5 was cracked,
> etc. But people have used cryptoloop now, and removing it from the
> kernel will lock them out of their own data, or prevent them from
> moving forward. There's no replacement for cryptoloop, so I can't just
> reconfigure X and still read my 147 DVDs full of business data, or
> access the current data on 34 laptops around the country.

Bill, I still don't think your complaints are justified.

You're only "locked out of your own data" if you knowingly upgrade to
a kernel that doesn't support cryptoloop.  Nobody's forcing you to do
that. 

The kernel developers owe *nothing* to J. Random User.  They are
either doing what they do for their own reasons (the "fun" of it), or
being paid by an organization with specific objectives (even if, in
Linus' case, the objective is just "make the best kernel possible,
based on your judgement and that of people you trust").

That said, of course none of them want to break things unnecessarily.
But they make technical decisions, with the goal of having the best
kernel, that do sometimes have painful consequences.  You're free, of
course, to disagree with those decisions and maintain your own kernel.

They don't owe you security fixes either.  Sorry, but that's the way
it is.  We're all lucky that they take security very seriously and
respond quickly to problems.

> In most cases CL is not expected to protect against goverment agencies
> but rather stolen laptops in airports (yes the pros have added MacOS
> and Linux to their business model) or the occasional lost DVD in the
> mail. Removing CL is not a hell of a lot better morally than these
> viruses which encrypt your data and then hold it for ransom, with the
> price being doing without security fixes in future kernels.

That last sentence is crap.

You're free to backport security fixes to cryptoloop-supporting
kernels forever, or pay someone to do so.  Or maintain a cryptoloop
patch against current kernels, or pay someone to do so.  Or write a
converter for cryptoloop data to whatever's currently in the kernel,
or pay someone to do so.

> Given that CL has minimal (essentially no) maintenence cost, I wish
> the ivory tower developers could understand that real people have
> invested real money in it, and real data in the technology. Since
> there is no alternative solution offered, CL is far better than no
> crypto at all, and I wish there were a few more developers who had
> experience working in the real word.

If you include a crypto solution in the mainstream kernel, you're in
some sense endorsing its security.  If that solution has known
weaknesses, I can understand wanting to either fix it or rip it out.
Crypto is hard enough to get right as it is.

Your "ivory tower" statement is really condescending.  Linux is way
past the stage where college students were the main contributors (if
it ever was so after Linus graduated). and a great majority of
developers now are paid to work on the kernel.  There are probably
very few of them that don't have at least a little sysadmin
experience.

If you've invested money and put important data in a system, and you
haven't contracted with anyone to support that system, supply security
fixes, and make sure it does what you want it to do, who's the fool?

Basically, you're complaining about something you get *for free* that
represents millions of hours of work, because it doesn't work quite
the way you want it to, when you have perfect freedom to make it meet
your needs by putting in your own time, effort and/or money.

-Doug
