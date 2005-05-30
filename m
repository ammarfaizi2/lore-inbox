Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261603AbVE3OVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbVE3OVf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 10:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbVE3OVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 10:21:33 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:62894 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261603AbVE3OV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 10:21:29 -0400
Message-ID: <429B2160.7010005@yahoo.com.au>
Date: Tue, 31 May 2005 00:21:20 +1000
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
References: <m1br6zxm1b.fsf@muc.de> <1117044019.5840.32.camel@sdietrich-xp.vilm.net> <20050526193230.GY86087@muc.de> <1117138270.1583.44.camel@sdietrich-xp.vilm.net> <20050526202747.GB86087@muc.de> <4296ADE9.50805@yahoo.com.au> <20050527120812.GA375@nietzsche.lynx.com> <429715DE.6030008@yahoo.com.au> <20050527233645.GA2283@nietzsche.lynx.com> <4297EB57.5090902@yahoo.com.au> <20050528054503.GA2958@nietzsche.lynx.com> <42981467.6020409@yahoo.com.au> <4299A98D.1080805@andrew.cmu.edu> <429ADEDD.4020805@yahoo.com.au> <429B1898.8040805@andrew.cmu.edu>
In-Reply-To: <429B1898.8040805@andrew.cmu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bruce wrote:
> Nick Piggin wrote:
> 
>> Sorry no, nobody answered me. What I did realize was that there
>> was a lot of noise nothing really got resolved.
> 
> 

[snip lots of stuff]

Sorry James, we were talking about hard realtime. Read the thread.
What's more, I don't think you understand how a nanokernel solution
would work, nor have much idea about the complexity of implementing
it in Linux (although that could have been a result of your thinking
that we weren't talking about hard-rt).

And my questions for which I got no answer were things like
"why is a single kernel superior to a nanokernel for hard-RT?",
"what deterministic services would a hard-RT Linux need to provide?"

So most of what you said is irrelevant, but I'll pick out a few bits.

[snip]

> Yes, you "shoot holes" by bringing up examples such as fork/exec and 
> other things RT apps would almost never do while expecting to meet 

No, that wasn't part of any of my hole shooting. I asked what operations
need to be realtime and have not had an answer. fork/exec was "prompting".

> deadlines.  Then at the same time, when someone describes what an RT 
> application typically does do, you claim how simple and trivial it all 
> is, and without knowing any of the details tell them that it'd be easy 
> to split it into separate processes.

Err, your example was "reading a configuration file". Not exactly
rocket science my good man.

> Please explain how a split-kernel 
> method supports a continuous progression from soft-realtime to 
> hard-realtime, where each set of API calls has associated latency 
> effects that may or may not be tolerable for a given application. That's 
> the problem space, and I can guarantee applications exist all along that 
> progression, and many don't fall cleanly into one side or the other.
> 

You say this like you have a confabulous solution ready to plonk
into the Linux kernel.

But it is not up to me to point out why one way is better than the
other because I am not asking to have anything merged (not saying
*you* are either, I joined this thread by asking an open ended
question).

>> I hate to say but I find this almost dishonest considering
>> assertions like "obviously superior" are being thrown around,
>> along with such fine explanations as "start writing realtime apps
>> and you'll find out".
> 
> 
> I said neither, why don't you take it up with the authors of those 
> comments.  Btw, Mach was extended to do RT in a project called RT-Mach. 
>  Since you like that approach so much, maybe you should ask yourself why 
> it failed.  You could also think about why the Jack people aren't using 
> something like RTAI with its nanokernel approach.  It's certainly not 
> because the people working on those systems are ignorant.
> 

I have a better idea. I won't read up on any of that, and I will go
and do my own thing and stop wasting my time on this thread. Then
whoever wants to start putting hard realtime functionality into Linux
can *tell* me why nanokernels failed, OK? Let's end the discussion
until then. It is going nowhere.

Send instant messages to your online friends http://au.messenger.yahoo.com 
