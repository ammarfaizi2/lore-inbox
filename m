Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261836AbVEaLHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbVEaLHJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 07:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbVEaLHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 07:07:08 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:16486 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261836AbVEaLGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 07:06:51 -0400
Message-ID: <429C453E.7080109@yahoo.com.au>
Date: Tue, 31 May 2005 21:06:38 +1000
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
References: <20050527233645.GA2283@nietzsche.lynx.com> <4297EB57.5090902@yahoo.com.au> <20050528054503.GA2958@nietzsche.lynx.com> <42981467.6020409@yahoo.com.au> <4299A98D.1080805@andrew.cmu.edu> <429ADEDD.4020805@yahoo.com.au> <429B1898.8040805@andrew.cmu.edu> <429B2160.7010005@yahoo.com.au> <20050530222747.GB9972@nietzsche.lynx.com> <429BBC2D.70406@yahoo.com.au> <20050531020957.GA10814@nietzsche.lynx.com> <429C2A64.1040204@andrew.cmu.edu> <429C2F72.7060300@yahoo.com.au> <429C4112.2010808@andrew.cmu.edu>
In-Reply-To: <429C4112.2010808@andrew.cmu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bruce wrote:
> Nick Piggin wrote:
> 
>> I have never been in any doubt as to the specific claims I have
>> made. I continually have been talking about hard realtime from
>> start to finish, and it appears that everyone now agrees with me
>> that for hard-RT, a nanokernel solution is better or at least
>> not obviously worse at this stage.
> 
> 
> It is only better in that if you need provable hard-RT *right now*, then 
> you have to use a nanokernel.  The RT patch doesn't provide guaranteed 
> hard-RT yet[1], but it may in the future.  Any RT application programmer 

This was my main line of questioning - what future direction will
do the RT guys want from the PREEMPT_RT work. I was concerned that
hard-realtime does not sound feasable for Linux.

[snip]

> 
> I think where we violently disagree is that in your earlier posts you 
> seemed to imply that a nanokernel hard-RT solution obviates the need for 
> something like preempt-RT.  That is not the case at all, and at the 

Actually I think that is also where we violently agree ;)
If you look at some of my earlier posts, you'll see I had to
add 'disclaimers' until I was blue in the face. But I don't
blame you for not wanting to crawl through all that / or not
seeing it.

Basically: I know they are orthogonal, and I don't disagree
that generally better scheduling and interrupt latency would be
nice for Linux to have.

Now I'll really stop posting. Sorry everyone.

Send instant messages to your online friends http://au.messenger.yahoo.com 
