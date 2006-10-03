Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030295AbWJCLO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030295AbWJCLO7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 07:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030307AbWJCLO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 07:14:59 -0400
Received: from 216-54-166-5.static.twtelecom.net ([216.54.166.5]:29139 "EHLO
	mx1.compro.net") by vger.kernel.org with ESMTP id S1030295AbWJCLO6
	(ORCPT <rfc822;linux-kerneL@vger.kernel.org>);
	Tue, 3 Oct 2006 07:14:58 -0400
Message-ID: <4522462F.4040704@compro.net>
Date: Tue, 03 Oct 2006 07:14:55 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
MIME-Version: 1.0
To: tglx@linutronix.de
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kerneL@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: RT exec for exercising RT kernel capabilities
References: <448876B9.9060906@compro.net>	 <1152916456.3119.92.camel@mindpipe>  <1152929059.5915.11.camel@localhost>	 <1152929428.3119.114.camel@mindpipe>  <1159828079.20801.9.camel@mindpipe> <1159828799.1386.86.camel@localhost.localdomain>
In-Reply-To: <1159828799.1386.86.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:
> On Mon, 2006-10-02 at 18:27 -0400, Lee Revell wrote:
>> On Fri, 2006-07-14 at 22:10 -0400, Lee Revell wrote:
>>> On Sat, 2006-07-15 at 04:04 +0200, Thomas Gleixner wrote:
>>>> On Fri, 2006-07-14 at 18:34 -0400, Lee Revell wrote:
>>>>> On Thu, 2006-06-08 at 15:12 -0400, Mark Hounschell wrote:
>>>>>> ftp://ftp.compro.net/public/rt-exec/
>>>>> The high res timers do not seem to be working.  Using 2.6.17-rt3 and
>>>>> glibc 2.3.6, I get the exact same (bad) results whether
>>>>> CONFIG_HIGH_RES_TIMERS is enabled or not.
>>>> Can you please send me a boot log ?
>>> Sent off-list.
>> I've discovered the problem - I was running rt-exec as a non-root user.
>>
>> Is the use of high res timers limited to root?
> 
> No. I guess the priority setting is not working as non-root.
> 
> 	tglx
> 

I think I put something in the README about this? Yep..

Mark

