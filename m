Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbUBVGp5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 01:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbUBVGp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 01:45:57 -0500
Received: from adsl-63-194-240-129.dsl.lsan03.pacbell.net ([63.194.240.129]:61189
	"EHLO mikef-fw.mikef-fw.matchmail.com") by vger.kernel.org with ESMTP
	id S261182AbUBVGpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 01:45:54 -0500
Message-ID: <4038501F.7090405@matchmail.com>
Date: Sat, 21 Feb 2004 22:45:51 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: Chris Wedgwood <cw@f00f.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Large slab cache in 2.6.1
References: <4037FCDA.4060501@matchmail.com> <20040222023638.GA13840@dingdong.cryptoapps.com> <Pine.LNX.4.58.0402211901520.3301@ppc970.osdl.org> <20040222031113.GB13840@dingdong.cryptoapps.com> <Pine.LNX.4.58.0402211919360.3301@ppc970.osdl.org> <20040222033111.GA14197@dingdong.cryptoapps.com> <4038299E.9030907@cyberone.com.au> <40382BAA.1000802@cyberone.com.au> <4038307B.2090405@cyberone.com.au> <40383300.5010203@matchmail.com> <4038402A.4030708@cyberone.com.au> <40384325.1010802@matchmail.com> <403845CB.8040805@cyberone.com.au>
In-Reply-To: <403845CB.8040805@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> 
> 
> Mike Fedyk wrote:
> 
>> Nick Piggin wrote:
>>
>>>
>>>
>>> Mike Fedyk wrote:
>>>
>>>> What is the kernel parameter to disable highmem?  I saw nohighio, 
>>>> but that's not it...
>>>>
>>>
>>> Not sure. That defeats the purpose of trying to get your setup
>>> working nicely though ;)
>>>
>>> Can you upgrade to 2.6.3-mm2? It would be ideal if you could
>>> test this patch against that kernel due to the other VM changes.
>>
>>
>>
>> I can test on another machine, but it doesn't have as much memory, and 
>> I'd have to use highmem emulation.
>>
> 
> Probably not worth the bother. It is easy enough for anyone to
> test random things, but the reason your feedback is so important
> is because you are actually *using* the system.

I completely understand what you're saying.  I have seen enough threads 
where someone refused to test patches.  So let me be more specific.

I'll have to test the kernel on two other machines for a few days before 
I put it on this particular machine.  Unfortunately, both of them have < 
1.5GB ram.

So let me know which patches are most likely to fix this problem.

PS, if I can apply them to my 2.6.1 kernel, then I wouldn't have to run 
the base kernel to compare changes of 2.6.1 -> 2.6.3 -> 2.6.3-mm -> your 
patch.

Each step would require a week-day to get a fair compairison.

Mike

