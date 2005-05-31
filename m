Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbVEaBWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbVEaBWd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 21:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbVEaBWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 21:22:32 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:9361 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261711AbVEaBWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 21:22:13 -0400
Message-ID: <429BBC3D.1070402@yahoo.com.au>
Date: Tue, 31 May 2005 11:22:05 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: James Bruce <bruce@andrew.cmu.edu>
CC: "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
References: <m1br6zxm1b.fsf@muc.de> <1117044019.5840.32.camel@sdietrich-xp.vilm.net> <20050526193230.GY86087@muc.de> <1117138270.1583.44.camel@sdietrich-xp.vilm.net> <20050526202747.GB86087@muc.de> <4296ADE9.50805@yahoo.com.au> <20050527120812.GA375@nietzsche.lynx.com> <429715DE.6030008@yahoo.com.au> <20050527233645.GA2283@nietzsche.lynx.com> <4297EB57.5090902@yahoo.com.au> <20050528054503.GA2958@nietzsche.lynx.com> <42981467.6020409@yahoo.com.au> <4299A98D.1080805@andrew.cmu.edu> <429ADEDD.4020805@yahoo.com.au> <429B1898.8040805@andrew.cmu.edu> <429B2160.7010005@yahoo.com.au> <429BA27A.5010406@andrew.cmu.edu>
In-Reply-To: <429BA27A.5010406@andrew.cmu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bruce wrote:
> Nick Piggin wrote:
> 
>> Sorry James, we were talking about hard realtime. Read the thread.
> 
> 
> hard realtime = mathematically provable maximum latency
> 
> Yes, you'll want a nanokernel for that, you're right.  That's because 
> one has to analyze every line of code, and protect against introduced 
> regressions, which is almost impossible given the pace that Linux-proper 

Thank you, James. Now please tell that to Bill. It would seem
that I haven't written enough "RT media apps" for him to take
me seriously ;)

> 
> If you look at your first two messages in this thread however, you seem 
> to be offering a nanokernel approach (in particular RTAI as suggested by 
> Cristoph) as an alternative to the RT-patch.  This is sort of confused 
> by the fact that Ingo called it "hard realtime" because he measured a 
> maximum latency during a stress test.  Unfortunately that's not really 
> hard realtime if you are just measuring it; Rather its "really damn good 
> soft realtime".  An analysis of code paths could be done to determine if 
> something really does satisfy hard-RT constraints, but to my knowledge 
> that's not on the table at this point.  So you're discussing soft 
> realtime if you're dicussing the RT patch.
> 

No, I clarified the point that the direction the RT people want
to go in is hard-realtime in the Linux kernel.

I'm very well aware of what the actual current PREEMPT_RT patch is,
and I was never talking about that particular patch.

> So its really just a misunderstanding; Nanokernels certainly still have 
> a place for some applications even with the RT patches applied (Ingo has 
> said as much).  However expecting audio applications such as Jack to 
> have to use RTAI is kind of silly, and would end up annoying the authors 
> of both (I'm sure the RTAI people have better things to do than support 
> ALSA drivers in RT mode).
> 

Yes, Jack is more of a soft realtime application, and in that case
Linux supports it already today (although perhaps not very well -
something the RT patch aims to improve).

[snip rest]

> 
> I really hope we understand each other now, but if not I guess it wasn't 
> to be.  Hopefully someone got something out of reading this discussion, 
> but I won't be posting on this branch of the thread anymore either.
> 

It seems that you do understand my position now, yes.
I'll try to refrain from posting further, too.

Nick

Send instant messages to your online friends http://au.messenger.yahoo.com 
