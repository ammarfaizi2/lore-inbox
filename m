Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262859AbTJUEt6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 00:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262910AbTJUEt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 00:49:58 -0400
Received: from dyn-ctb-210-9-241-130.webone.com.au ([210.9.241.130]:15621 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S262859AbTJUEt4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 00:49:56 -0400
Message-ID: <3F94BADF.6040104@cyberone.com.au>
Date: Tue, 21 Oct 2003 14:49:35 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: venom@sns.it
CC: Dave Olien <dmo@osdl.org>, rwhron@earthlink.net,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [BENCHMARK] I/O regression after 2.6.0-test5
References: <Pine.LNX.4.43.0310200953480.26518-100000@cibs9.sns.it>
In-Reply-To: <Pine.LNX.4.43.0310200953480.26518-100000@cibs9.sns.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guys,
If you have time, would you please try testing as-iosched.c from
test5 in a later kernel (it won't go into test8-mm1 though).

Thanks


venom@sns.it wrote:

>me too, on some self made db benchs on both mysql and postgresql,  testing, of
>course, I/O.
>
>On Sun, 19 Oct 2003, Dave Olien wrote:
>
>
>>Date: Sun, 19 Oct 2003 21:51:23 -0700
>>From: Dave Olien <dmo@osdl.org>
>>To: rwhron@earthlink.net
>>Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
>>Subject: Re: [BENCHMARK] I/O regression after 2.6.0-test5
>>
>>
>>Yup, we've seen similar regression on tiobench and reaim workloads.
>>
>>On Sun, Oct 19, 2003 at 08:37:45PM -0400, rwhron@earthlink.net wrote:
>>
>>>There was about a 50% regression in jobs/minute in AIM7
>>>database workload on quad P3 Xeon.  The CPU time has not
>>>gone up, so the extra run time is coming from something
>>>else.  (I/O or I/O scheduler?)
>>>
>>>tiobench sequential reads has a significant regression too.
>>>
>>>Regression appears unrelated to filesystem type.
>>>
>>>dbench was not affected.
>>>
>>>The AIM7 was run on ext2.
>>>
>>>      
>>>

