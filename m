Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751236AbWELLkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbWELLkG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 07:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWELLkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 07:40:05 -0400
Received: from 216-54-166-5.static.twtelecom.net ([216.54.166.5]:35543 "EHLO
	mx1.compro.net") by vger.kernel.org with ESMTP id S1751236AbWELLkE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 07:40:04 -0400
Message-ID: <4464740C.8060305@compro.net>
Date: Fri, 12 May 2006 07:39:56 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, john stultz <johnstul@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC][PATCH -rt] irqd starvation on SMP by a single process?
References: <1147401812.1907.14.camel@cog.beaverton.ibm.com> <20060512055025.GA25824@elte.hu> <Pine.LNX.4.58.0605120337150.26721@gandalf.stny.rr.com>
In-Reply-To: <Pine.LNX.4.58.0605120337150.26721@gandalf.stny.rr.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> 
> On Fri, 12 May 2006, Ingo Molnar wrote:
> 
>> ah. This actually uncovered a real bug. We were calling __do_softirq()
>> with interrupts enabled (and being preemptible) - which is certainly
>> bad.
> 
> Hmm, I wonder if this is also affecting Mark's problem.
> 

I thought the same thing when I read it??

Mark

