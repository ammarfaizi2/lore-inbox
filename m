Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261676AbULNVxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261676AbULNVxp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 16:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbULNVxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 16:53:44 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:57583 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261676AbULNVxO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 16:53:14 -0500
Message-ID: <41BF60A1.1080606@mvista.com>
Date: Tue, 14 Dec 2004 13:52:33 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Steven Rostedt <rostedt@goodmis.org>, Lee Revell <rlrevell@joe-job.com>,
       LKML <linux-kernel@vger.kernel.org>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc3-mm1-V0.7.33-0
References: <20041122005411.GA19363@elte.hu> <20041123175823.GA8803@elte.hu> <20041124101626.GA31788@elte.hu> <20041203205807.GA25578@elte.hu> <20041207132927.GA4846@elte.hu> <20041207141123.GA12025@elte.hu> <20041214132834.GA32390@elte.hu> <1103052853.3582.46.camel@localhost.localdomain> <1103054908.14699.20.camel@krustophenia.net> <1103057144.3582.51.camel@localhost.localdomain> <20041214211828.GA17216@elte.hu>
In-Reply-To: <20041214211828.GA17216@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> 
>>>>[RFC]
>>>>
>>>>Ingo,
>>>>
>>>>Any thought about adding a one shot timer for the system? 
>>>>
>>>
>>>Isn't this what George Anzinger is working on?
>>>
>>>http://sourceforge.net/projects/high-res-timers/
>>>
>>>Lee
>>>
>>
>>A quick look at this looks like this is what I was looking for. I'd
>>need to review the code in a more detailed aspect but first glance,
>>Yes, this is what I want.
>>
>>Now, since High Res-timers and RT seem to go together, what are the
>>plans for merging these?  If this is indeed what I need, then I'll be
>>doing it to myself, [...]
> 
> 
> i've been thinking about it on and off. If you would/could try it that
> would certainly help. RT for Linux is a dance of many small steps.
> 
> the two projects are obviously complementary and i have no intention to
> reinvent the wheel in any way. Best would be to bring hires timers up to
> upstream-mergable state (independently of the -RT patch) and ask Andrew
> to include it in -mm, then i'd port -RT to it automatically.

Well, I guess I am just backward :)  I plan to port it to the current RT today 
or tomorrow (if all goes well).  I will then work on the changes needed to get 
it into -mm.  Guess I will be supporting two versions for a bit...


-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

