Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261809AbVE3XF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbVE3XF0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 19:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbVE3XF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 19:05:26 -0400
Received: from opersys.com ([64.40.108.71]:47375 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261809AbVE3XFO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 19:05:14 -0400
Message-ID: <429B9E85.2000709@opersys.com>
Date: Mon, 30 May 2005 19:15:17 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: "Bill Huey (hui)" <bhuey@lnxw.com>
CC: Esben Nielsen <simlo@phys.au.dk>, Nick Piggin <nickpiggin@yahoo.com.au>,
       kus Kusche Klaus <kus@keba.com>, James Bruce <bruce@andrew.cmu.edu>,
       Andi Kleen <ak@muc.de>, Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
References: <Pine.OSF.4.05.10505301934001.31148-100000@da410.phys.au.dk> <429B61F7.70608@opersys.com> <20050530223434.GC9972@nietzsche.lynx.com> <429B9880.1070604@opersys.com> <20050530224949.GE9972@nietzsche.lynx.com>
In-Reply-To: <20050530224949.GE9972@nietzsche.lynx.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Bill Huey (hui) wrote:
> Paths entering back into userspace are simple like the use of read() to
> respond to events.

Sure, but like Andi said, general increased responsiveness is not exclusive
to PREEMPT_RT, and any effort to reduce latency is welcome.

> Sorry, the RT patch really doesn't effect general kernel development
> dramatically. It's just exploiting SMP work already in place to get data
> safety and the like. It does however kill all bogus points in the kernel
> that spin-waits for something to happen, which is a positive thing for the
> kernel in general since it indicated sloppy code. If anything it makes the
> kernel code cleaner.

But wasn't the same said about the existing preemption code? Yet, most
distros ship with it disabled and some developers still feel that there
are no added benefits. What's the use if everyone is shipping kernels
with the feature disabled? From a practical point of view, isn't it then
obvious that such features catter for a minority? Wouldn't it therefore
make sense to isolate such changes from the rest of the kernel in as
much as possible? From what I read in response elsewhere, it does indeed
seem that there are many who feel that the changes being suggested are
far too instrusive without any benefit for most Linux users. But again,
I'm just another noise-maker on this list. Reading the words of those
who actually maintain this stuff is the best indication for me as to
what the real-time-linux community can and cannot expect to get into
the kernel.

> This is last day of vacation, but it doesn't feel like it unfortunately :}

I'm sorry you feel this way ... you do have the choice of not responding.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
