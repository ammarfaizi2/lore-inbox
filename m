Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbUBVG6V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 01:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbUBVG6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 01:58:21 -0500
Received: from mail-10.iinet.net.au ([203.59.3.42]:26566 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261183AbUBVG6R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 01:58:17 -0500
Message-ID: <40385306.6090301@cyberone.com.au>
Date: Sun, 22 Feb 2004 17:58:14 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: Chris Wedgwood <cw@f00f.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Large slab cache in 2.6.1
References: <4037FCDA.4060501@matchmail.com> <20040222023638.GA13840@dingdong.cryptoapps.com> <Pine.LNX.4.58.0402211901520.3301@ppc970.osdl.org> <20040222031113.GB13840@dingdong.cryptoapps.com> <Pine.LNX.4.58.0402211919360.3301@ppc970.osdl.org> <20040222033111.GA14197@dingdong.cryptoapps.com> <4038299E.9030907@cyberone.com.au> <40382BAA.1000802@cyberone.com.au> <4038307B.2090405@cyberone.com.au> <40383300.5010203@matchmail.com> <4038402A.4030708@cyberone.com.au> <40384325.1010802@matchmail.com> <403845CB.8040805@cyberone.com.au> <4038501F.7090405@matchmail.com>
In-Reply-To: <4038501F.7090405@matchmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mike Fedyk wrote:

> Nick Piggin wrote:
>
>>
>> Probably not worth the bother. It is easy enough for anyone to
>> test random things, but the reason your feedback is so important
>> is because you are actually *using* the system.
>
>
> I completely understand what you're saying.  I have seen enough 
> threads where someone refused to test patches.  So let me be more 
> specific.
>
> I'll have to test the kernel on two other machines for a few days 
> before I put it on this particular machine.  Unfortunately, both of 
> them have < 1.5GB ram.
>

That is quite alright. I didn't intend to sound pushy in that
message, and I fully understand if you refuse to test patches on
your production machine.

> So let me know which patches are most likely to fix this problem.
>
> PS, if I can apply them to my 2.6.1 kernel, then I wouldn't have to 
> run the base kernel to compare changes of 2.6.1 -> 2.6.3 -> 2.6.3-mm 
> -> your patch.
>
> Each step would require a week-day to get a fair compairison.
>

The last patch I posted would be a good one to test if you possibly
can. You should hear someone shout within a few days if it does
anything nasty, so the 2.6.3-mm+patch path is probably safer ;)

Nick

