Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933584AbWK3JlO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933584AbWK3JlO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 04:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933629AbWK3JlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 04:41:14 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:17296 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S933584AbWK3JlF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 04:41:05 -0500
Date: Thu, 30 Nov 2006 09:41:03 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Break out memory initialisation code from page_alloc.c
 to mem_init.c
In-Reply-To: <20061129131448.b5761339.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0611300936570.1076@skynet.skynet.ie>
References: <20061129180045.GA16463@skynet.ie> <20061129131448.b5761339.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2006, Andrew Morton wrote:

> On Wed, 29 Nov 2006 18:00:47 +0000
> mel@skynet.ie (Mel Gorman) wrote:
>
>> page_alloc.c contains a large amount of memory initialisation code which
>> obscures the purpose of the file. This patch breaks out the initialisation
>> code into a separate file to make page_alloc.c a bit easier to read.
>>
>> This is a repost from a long time ago.  At the time it was last posted,
>> there was too much churn in page_alloc.c and it was put on the back-burner.
>> However, there is still a lot going on in page_alloc.c so the time still
>> might not be right.
>
> yeah, it spits a 58k reject already.

I'm not suprised.

> There's basically never a good time for this,
> but the best time is around 2.6.x-rc1.
>

Grand, I'll take another look around then. It's not very important anyway.

Thanks

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
