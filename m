Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbTIBXui (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 19:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbTIBXui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 19:50:38 -0400
Received: from dyn-ctb-210-9-241-57.webone.com.au ([210.9.241.57]:19460 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S261324AbTIBXu0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 19:50:26 -0400
Message-ID: <3F552CBB.1060906@cyberone.com.au>
Date: Wed, 03 Sep 2003 09:50:19 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Nick's scheduler policy v10
References: <3F5044DC.10305@cyberone.com.au> <1806700000.1062361257@[10.10.2.4]> <1807550000.1062362498@[10.10.2.4]> <3F52A546.9020608@cyberone.com.au> <6860000.1062441073@[10.10.2.4]> <3F544F11.4010700@cyberone.com.au> <127320000.1062514664@[10.10.2.4]>
In-Reply-To: <127320000.1062514664@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Martin J. Bligh wrote:

>>>Not convinced of that - mm performs worse than mainline for me.
>>>
>>Well, one of Con's patches caused a lot of idle time on volanomark.
>>The reason for the change was unclear. I guess either a fairness or
>>wakeup latency change (yes, it was a very scientific process, ahem).
>>
>>Anyway, in the process of looking at the load balancing, we found
>>and fixed a problem (although it might now possibly over balance).
>>This did cure most of the idle problems.
>>
>>So it could just be small changes causing things to go out of whack.
>>I will try to get better data after (if ever) the thing is working
>>nicely on the desktop.
>>
>
>I think Con and I worked out that the degredations I was seeing 
>(on kernbench and SDET) were due to (in his words) "my hacks throwing the 
>cc cpu hogs onto the expired array more frequently".
>
>

This didn't explain the huge idle time increases on volanomark and
SPECjbb I think.



