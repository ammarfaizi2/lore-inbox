Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265237AbUBIQb6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 11:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265242AbUBIQb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 11:31:57 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:58637 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S265237AbUBIQb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 11:31:56 -0500
Message-ID: <4027B758.8060908@techsource.com>
Date: Mon, 09 Feb 2004 11:37:44 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: "Martin J. Bligh" <mbligh@aracnet.com>,
       Rick Lindsley <ricklind@us.ibm.com>, Anton Blanchard <anton@samba.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, dvhltc@us.ibm.com
Subject: Re: [PATCH] Load balancing problem in 2.6.2-mm1
References: <200402062311.i16NBdF14365@owlet.beaverton.ibm.com> <40242152.5030606@cyberone.com.au> <231480000.1076110387@flay> <4024261E.5070702@cyberone.com.au> <232690000.1076111266@flay> <40242D14.6070908@cyberone.com.au>
In-Reply-To: <40242D14.6070908@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nick Piggin wrote:

> 
> Can we keep current behaviour default, and if arches want to
> override it they can? And if someone one day does testing to
> show it really isn't a good idea, then we can change the default.
> 
> I like to try stick to the fairness first approach.
> 
> We got quite a few complaints about unfairness when the
> scheduler used to keep 2 on one cpu and 1 on another, even in
> development kernels. I suspect that most wouldn't have known
> one way or the other if only top showed 66% each, but still.
> 


Stupid question:  Does the balancing consider process priority?  Is it 
unfair to have two lower pri tasks always on one cpu while the highest 
pri of the three is always by itself?

