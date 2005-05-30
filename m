Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261477AbVE3L2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261477AbVE3L2w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 07:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbVE3L1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 07:27:07 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:8354 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261468AbVE3LZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 07:25:06 -0400
Message-ID: <429AF80E.6090509@yahoo.com.au>
Date: Mon, 30 May 2005 21:25:02 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Bill Huey (hui)" <bhuey@lnxw.com>
CC: Andi Kleen <ak@muc.de>, Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
References: <m1br6zxm1b.fsf@muc.de> <1117044019.5840.32.camel@sdietrich-xp.vilm.net> <20050526193230.GY86087@muc.de> <1117138270.1583.44.camel@sdietrich-xp.vilm.net> <20050526202747.GB86087@muc.de> <4296ADE9.50805@yahoo.com.au> <20050527120812.GA375@nietzsche.lynx.com> <429715DE.6030008@yahoo.com.au> <20050527233645.GA2283@nietzsche.lynx.com> <4297EB57.5090902@yahoo.com.au> <20050528054503.GA2958@nietzsche.lynx.com> <42981467.6020409@yahoo.com.au>
In-Reply-To: <42981467.6020409@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Bill Huey (hui) wrote:

>>
>> Uh, not really. Have you looked at the patch or are you inserting
>> hysteria in the discussion again ? :) Sounds like hysteria.
>>
> 
> OK, I'll start small. What have you done with the tasklist lock?
> How did you make signal delivery time deterministic?
> 
> How about fork/clone? Or don't those need to be realtime? What
> exactly _do_ you need to be realtime? I'm not asking rhetorical
> questions here.
> 

Let me ask another question while you're thinking about that.
Note, this is a *specific* question that can easily be answered
without waffling about XFS or telling me to start writing RT
media apps, or accusing me of spreading hysteria...

OK:

I think it has been conceeded that a realtime Linux kernel
cannot be enabled by default because of prohibitive overhead,
right? I think this is even the case for PREEMPT_RT, which is
not hard-RT. (Correct me if I'm wrong).

Suppose you had a system where you need some RT operations,
but cannot tolerate such overhead for general purpose
performance processing.

So by definition you have excluded a single kernel approach.
A nanokernel is not clearly excluded. In fact, maybe it is
possible to run the Linux image with little overhead? Maybe
almost none with the right CPU hardware? (correct me...)

If you get to here without correcting me, my question is:
does such an application exist? Silly example is a cell
phone + JVM, but something really interrupt heavy (and
maybe SMP as well) might be better to cripple PREEMPT_RT.

Thanks. I can think of some other specific questions too,
when you've addressed these.
Send instant messages to your online friends http://au.messenger.yahoo.com 
