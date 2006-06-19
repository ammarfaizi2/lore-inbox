Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932361AbWFSLjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbWFSLjn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 07:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbWFSLjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 07:39:43 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:18651 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932361AbWFSLjn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 07:39:43 -0400
Message-ID: <44968B6D.8040301@in.ibm.com>
Date: Mon, 19 Jun 2006 17:03:01 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM India Private Limited
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Andrew Morton <akpm@osdl.org>, dev@openvz.org, vatsa@in.ibm.com,
       ckrm-tech@lists.sourceforge.net, bsingharora@gmail.com, efault@gmx.de,
       linux-kernel@vger.kernel.org, kernel@kolivas.org, sam@vilain.net,
       kingsley@aurema.com, mingo@elte.hu, Peter Williams <peterw@aurema.com>,
       rene.herman@keyaccess.nl
Subject: Re: [ckrm-tech] [PATCH 0/4] sched: Add CPU rate caps
References: <20060618082638.6061.20172.sendpatchset@heathwren.pw.nest>	<20060618025046.77b0cecf.akpm@osdl.org>	<449529FE.1040008@bigpond.net.au>	<4495EC40.70301@in.ibm.com>	<4495F7FE.9030601@aurema.com> <449609E4.1030908@in.ibm.com>	<44961758.6070305@bigpond.net.au> <44961A77.800@in.ibm.com>	<44961EFC.8080809@bigpond.net.au> <4496608D.6000502@in.ibm.com> <44968C19.7050501@bigpond.net.au>
In-Reply-To: <44968C19.7050501@bigpond.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:

> 
> You're over engineering and you're not solving the problem.  You're just 
> moving it down a bit.
> 

> 
>>
>>2. In a group based cap management system, schedule some tasks (highest 
>>priority)
>>  until their cap run out. In the subsequent rounds pick and choose 
>>tasks that
>>  did not get a chance to run earlier.
>>
>>Solving this is indeed a interesting problem.
>>
> 
> 
> Once again, you're over engineering and probably making the problem worse.
> 

I like this term over-engineering. Lets focus on the solution for the most
common case and see what works out. I was pointing you to the possible
limitations of the approach, which is always a good thing to do in engineering.

> Peter


-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
