Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbUCAJ1n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 04:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbUCAJ1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 04:27:43 -0500
Received: from mail-07.iinet.net.au ([203.59.3.39]:36563 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261188AbUCAJ1i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 04:27:38 -0500
Message-ID: <40430204.6040901@cyberone.com.au>
Date: Mon, 01 Mar 2004 20:27:32 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: MM VM patches was: 2.6.3-mm4
References: <20040225185536.57b56716.akpm@osdl.org> <4042F38B.8020307@matchmail.com> <4042F7E6.1050904@cyberone.com.au> <4042FCBC.7000809@matchmail.com>
In-Reply-To: <4042FCBC.7000809@matchmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mike Fedyk wrote:

> Nick Piggin wrote:
>
>>
>>
>> There are a few things backed out now in 2.6.4-rc1-mm1, and quite a
>> few other changes. I hope we can trouble you to test 2.6.4-rc1-mm1?
>
>
> Yes, I saw that, but since I wasn't using the new code, I chose to 
> keep it in the "-mm4" thread. :-D
>
> I'll backport it to 2.6.3 if it doesn't patch with "-F3"...
>

Actually, see my other post. It is possible you'll have the same
problem.

>> Tell me, do you have highmem enabled on this system? If so, swapping
>
>
> Yes, to get that extra 128MB ram. :)
>


Yeah thats fine. I think this would be the right thing to do,
especially for a file server. It is something that should work.


>> might be explained by the batching patch. With it, a small highmem
>> zone could possibly place quite a lot more pressure on a large
>> ZONE_NORMAL.
>>
>> 2.6.4-rc1-mm1 sould do much better here.
>
>
> OK, I'll give that one a shot Monday or Tuesday night.
>
> So, I'll merge up 2.6.3 + "vm of rc1-mm1" and tell you guys what I see.
>

I'm not so hopeful for you anymore :P

> Are the graphs helpful at all?
>


My eyes! The goggles, they do nothing!

They have a lot of good info but I'm a bit hard pressed working
out what kernel is running where, and it's a bit hard working out
all the shades of blue on my crappy little monitor.

But if they were easier to read I reckon they'd be useful ;)

