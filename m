Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbWFFK5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbWFFK5k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 06:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbWFFK5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 06:57:40 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:10441 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1750803AbWFFK5j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 06:57:39 -0400
Date: Tue, 6 Jun 2006 11:57:37 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm3
In-Reply-To: <20060605115456.c2b1e156.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0606061055410.13396@skynet.skynet.ie>
References: <20060603232004.68c4e1e3.akpm@osdl.org> <20060605175637.GA16186@skynet.ie>
 <20060605115456.c2b1e156.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jun 2006, Andrew Morton wrote:

> On Mon, 5 Jun 2006 18:56:37 +0100
> mel@csn.ul.ie (Mel Gorman) wrote:
>
>>
>> I am seeing more networking-related funniness with 2.6.17-rc5-mm3 on the
>> same machine previously fixed by git-net-llc-fix.patch. The console log is
>> below. I've done no investigation work in case it's a known problem.
>
> It's not a known problem, afaik.
>
>> ...
>> Starting anacron: [  OK  ]
>> Starting atd: [  OK  ]
>> Starting Avahi daemon: [  OK  ]
>> Starting cups-config-daemon: [  OK  ]
>> Starting HAL daemon: [  OK  ]
>> Fedora Core release 5 (Bordeaux)
>> Kernel 2.6.17-rc5-mm2-autokern1 on an x86_64

Bah, I'm a spanner. The patches I was testing were rebased to the latest 
-mm, but the kernel version they were then tested on was not changed. This 
was probably the LLC bug with a different shaped error and the first set 
of tests are passing with -mm3. Sorry for the noise.

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
