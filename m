Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964976AbWFSXKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbWFSXKa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 19:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964977AbWFSXKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 19:10:30 -0400
Received: from alt.aurema.com ([203.217.18.57]:61530 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S964976AbWFSXKa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 19:10:30 -0400
Message-ID: <44972EB3.8090400@aurema.com>
Date: Tue, 20 Jun 2006 09:09:39 +1000
From: Peter Williams <peterw@aurema.com>
Organization: Aurema Pty Ltd
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: balbir@in.ibm.com
CC: Peter Williams <pwil3058@bigpond.net.au>, Andrew Morton <akpm@osdl.org>,
       dev@openvz.org, vatsa@in.ibm.com, ckrm-tech@lists.sourceforge.net,
       bsingharora@gmail.com, efault@gmx.de, linux-kernel@vger.kernel.org,
       kernel@kolivas.org, sam@vilain.net, kingsley@aurema.com, mingo@elte.hu,
       rene.herman@keyaccess.nl
Subject: Re: [ckrm-tech] [PATCH 0/4] sched: Add CPU rate caps
References: <20060618082638.6061.20172.sendpatchset@heathwren.pw.nest>	<20060618025046.77b0cecf.akpm@osdl.org>	<449529FE.1040008@bigpond.net.au>	<4495EC40.70301@in.ibm.com>	<4495F7FE.9030601@aurema.com> <449609E4.1030908@in.ibm.com>	<44961758.6070305@bigpond.net.au> <44961A77.800@in.ibm.com>	<44961EFC.8080809@bigpond.net.au> <4496608D.6000502@in.ibm.com> <44968C19.7050501@bigpond.net.au> <44968B6D.8040301@in.ibm.com>
In-Reply-To: <44968B6D.8040301@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh wrote:
> Peter Williams wrote:
> 
>>
>> You're over engineering and you're not solving the problem.  You're 
>> just moving it down a bit.
>>
> 
>>
>>>
>>> 2. In a group based cap management system, schedule some tasks 
>>> (highest priority)
>>>  until their cap run out. In the subsequent rounds pick and choose 
>>> tasks that
>>>  did not get a chance to run earlier.
>>>
>>> Solving this is indeed a interesting problem.
>>>
>>
>>
>> Once again, you're over engineering and probably making the problem 
>> worse.
>>
> 
> I like this term over-engineering. Lets focus on the solution for the most
> common case and see what works out. I was pointing you to the possible
> limitations of the approach, which is always a good thing to do in 
> engineering.

And I was pointing out that it's a fundamental limitation that can't be 
avoided no matter which implementation route you follow.

Peter
-- 
Dr Peter Williams, Chief Scientist         <peterw@aurema.com>
Aurema Pty Limited
Level 2, 130 Elizabeth St, Sydney, NSW 2000, Australia
Tel:+61 2 9698 2322  Fax:+61 2 9699 9174 http://www.aurema.com
