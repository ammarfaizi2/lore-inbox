Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751590AbWEaNTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590AbWEaNTO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 09:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751578AbWEaNTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 09:19:14 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:21519 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751384AbWEaNTN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 09:19:13 -0400
Message-ID: <447D975B.3070700@openvz.org>
Date: Wed, 31 May 2006 17:17:15 +0400
From: Kirill Korotaev <dev@openvz.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Peter Williams <pwil3058@bigpond.net.au>
CC: balbir@in.ibm.com, Mike Galbraith <efault@gmx.de>,
       Con Kolivas <kernel@kolivas.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [RFC 2/5] sched: Add CPU rate soft caps
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>	 <20060526042041.2886.69840.sendpatchset@heathwren.pw.nest>	 <661de9470605262331w2e2258a7r41e2aab10895955f@mail.gmail.com>	 <4477F9DC.8090107@bigpond.net.au> <4478EA9D.4030201@bigpond.net.au>	 <661de9470605280038l40e53357ka3043dabd95de5fc@mail.gmail.com>	 <4479A71C.4060604@bigpond.net.au> <661de9470605280742o70fb6fc9g34ead234d377a1e0@mail.gmail.com> <447A31DE.3060601@bigpond.net.au>
In-Reply-To: <447A31DE.3060601@bigpond.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I understand that, I was talking about fairness between capped tasks
>> and what might be considered fair or intutive between capped tasks and
>> regular tasks. Of course, the last point is debatable ;)
> 
> 
> Well, the primary fairness mechanism in the scheduler is the time slice 
> allocation and the capping code doesn't fiddle with those so there 
> should be a reasonable degree of fairness (taking into account "nice") 
> between capped tasks.  To improve that would require allocating several 
> new priority slots for use by tasks exceeding their caps and fiddling 
> with those.  I don't think that it's worth the bother.
I suppose it should be handled still. a subjective feeling :)

BTW, do you have any test results for your patch?
It would be interesting to see how precise these limitations are and 
whether or not we should bother for the above...

Kirill

