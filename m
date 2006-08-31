Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932430AbWHaXwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbWHaXwW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 19:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbWHaXwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 19:52:22 -0400
Received: from omta02ps.mx.bigpond.com ([144.140.83.154]:55729 "EHLO
	omta02ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932430AbWHaXwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 19:52:22 -0400
Message-ID: <44F77632.7030407@bigpond.net.au>
Date: Fri, 01 Sep 2006 09:52:18 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Martin Ohlin <martin.ohlin@control.lth.se>
CC: Mike Galbraith <efault@gmx.de>, balbir@in.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: A nice CPU resource controller
References: <44F5AB45.8030109@control.lth.se>	 <661de9470608300841o757a8704te4402a7015b230c5@mail.gmail.com>	 <44F6365A.8010201@bigpond.net.au>	 <1157007190.6035.14.camel@Homer.simpson.net> <1157010140.18561.23.camel@Homer.simpson.net> <44F6BB8A.7090001@control.lth.se>
In-Reply-To: <44F6BB8A.7090001@control.lth.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02ps.mx.bigpond.com from [147.10.128.202] using ID pwil3058@bigpond.net.au at Thu, 31 Aug 2006 23:52:19 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Ohlin wrote:
> Mike Galbraith wrote:
>> On Thu, 2006-08-31 at 06:53 +0000, Mike Galbraith wrote:
>>> On Thu, 2006-08-31 at 11:07 +1000, Peter Williams wrote:
>>>
>>>> But your implication here is valid.  It is better to fiddle with the 
>>>> dynamic priorities than with nice as this leaves nice for its 
>>>> primary purpose of enabling the sysadmin to effect the allocation of 
>>>> CPU resources based on external considerations.
>>> I don't understand.  It _is_ the administrator fiddling with nice based
>>> on external considerations.  It just steadies the administrator's hand.
>>
>> When extended to groups, I see your point.  The admin would lose his
>> ability to apportion bandwidth _within_ the group because he's already
>> turned his only knob.  That is going to be just as much of a problem for
>> other methods though, and is just a question of how much complexity you
>> want to pay to achieve fine grained control.
> 
> I do not see the problem. Let's say I create a group of three tasks and 
> give it 50% of the CPU bandwidth (perhaps by using the same nice value 
> for all the tasks in this group). If I then want to apportion the 
> bandwidth within the group as you say, then the same thing can be done 
> by treating them as individual tasks.
> 
> Maybe I am wrong, but as I see it, if one wants to control on a group 
> level, then the individual shares within the group are not that 
> important. If the individual share is important, then it should be 
> controlled on a per-task level. Please tell me if I am wrong.

It's not that the control can't be done using nice.  It's that using 
nice to do the control stops nice being used for its original purpose. 
Some may not see that as a problem BUT some will.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
