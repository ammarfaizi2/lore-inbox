Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266069AbUJTSZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266069AbUJTSZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 14:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268989AbUJTSWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 14:22:45 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:17166 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S268954AbUJTSOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 14:14:15 -0400
Message-ID: <4176ADA1.1090802@techsource.com>
Date: Wed, 20 Oct 2004 14:25:37 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Arjan van de Ven <arjanv@redhat.com>, Andrea Arcangeli <andrea@novell.com>,
       Hugh Dickins <hugh@veritas.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Wedgwood <cw@f00f.org>, LKML <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
References: <593560000.1094826651@[10.10.2.4]>	 <Pine.LNX.4.44.0409101555510.16784-100000@localhost.localdomain>	 <20040910151538.GA24434@devserv.devel.redhat.com>	 <20040910152852.GC15643@x30.random>	 <20040910153421.GD24434@devserv.devel.redhat.com>	 <41768858.8070709@techsource.com>	 <20041020153521.GB21556@devserv.devel.redhat.com>	 <1098290345.1429.65.camel@krustophenia.net>	 <4176A749.8050306@techsource.com> <1098294932.1429.153.camel@krustophenia.net>
In-Reply-To: <1098294932.1429.153.camel@krustophenia.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Lee Revell wrote:

>>>
>>>The IDE I/O completion in hardirq context means that one can run for
>>>almost 3ms.  Apparently at OLS it was decided that the target for
>>>desktop responsiveness was 1ms.  So this is a real problem.
>>
>>What is happening that takes 3ms, and why can't it be broken up?
>>
> 
> 
> http://lkml.org/lkml/2004/7/24/26

Ah, I see.  Lots of cache misses.



> 
>>>What exactly do you mean by "draconian"?
>>
>>In this case, I mean extremely harsh and restrictive.  Usually, it means 
>>"excessively harsh", but in this case, I mean that in a good way.  :)
>>
> 
> 
> Heh, I know what the word means, I was asking what the specific rules
> are that could be considered as such.
> 
>

I believe using the word 'draconian' was a poor choice on my part. 
Maybe "strictly bounded with no exceptions" would be a better way of 
expressing it.

