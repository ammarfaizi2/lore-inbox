Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbUBVGBw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 01:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbUBVGBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 01:01:52 -0500
Received: from mail-10.iinet.net.au ([203.59.3.42]:53462 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261166AbUBVGBu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 01:01:50 -0500
Message-ID: <403845CB.8040805@cyberone.com.au>
Date: Sun, 22 Feb 2004 17:01:47 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: Chris Wedgwood <cw@f00f.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Large slab cache in 2.6.1
References: <4037FCDA.4060501@matchmail.com> <20040222023638.GA13840@dingdong.cryptoapps.com> <Pine.LNX.4.58.0402211901520.3301@ppc970.osdl.org> <20040222031113.GB13840@dingdong.cryptoapps.com> <Pine.LNX.4.58.0402211919360.3301@ppc970.osdl.org> <20040222033111.GA14197@dingdong.cryptoapps.com> <4038299E.9030907@cyberone.com.au> <40382BAA.1000802@cyberone.com.au> <4038307B.2090405@cyberone.com.au> <40383300.5010203@matchmail.com> <4038402A.4030708@cyberone.com.au> <40384325.1010802@matchmail.com>
In-Reply-To: <40384325.1010802@matchmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mike Fedyk wrote:

> Nick Piggin wrote:
>
>>
>>
>> Mike Fedyk wrote:
>>
>>> What is the kernel parameter to disable highmem?  I saw nohighio, 
>>> but that's not it...
>>>
>>
>> Not sure. That defeats the purpose of trying to get your setup
>> working nicely though ;)
>>
>> Can you upgrade to 2.6.3-mm2? It would be ideal if you could
>> test this patch against that kernel due to the other VM changes.
>
>
> I can test on another machine, but it doesn't have as much memory, and 
> I'd have to use highmem emulation.
>

Probably not worth the bother. It is easy enough for anyone to
test random things, but the reason your feedback is so important
is because you are actually *using* the system.

> I'd prefer to not have to restart this machine and put a test kernel 
> on it.
>

Fair enough. Maybe if we can get enough testing, some of the mm
changes can get into 2.6.4? I'm sure Linus is turning pale, maybe
we'd better wait until 2.6.10 ;)

>>
>> Chris, could you test this too please? Thanks.
>
>
> Yes, Chris do you have any highmem machines where you can test this 
> patch?
>

The system he's testing on has 1.5G too.


