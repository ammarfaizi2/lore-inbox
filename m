Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292926AbSCEL4e>; Tue, 5 Mar 2002 06:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292911AbSCEL4Z>; Tue, 5 Mar 2002 06:56:25 -0500
Received: from [195.63.194.11] ([195.63.194.11]:32780 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S292907AbSCEL4N>; Tue, 5 Mar 2002 06:56:13 -0500
Message-ID: <3C84B1FB.2050003@evision-ventures.com>
Date: Tue, 05 Mar 2002 12:54:35 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.6-pre2 IDE cleanup 16
In-Reply-To: <3C84A34E.6060708@evision-ventures.com> <Pine.LNX.4.44.0203051307080.12437-100000@netfinity.realnet.co.sz> <20020305112843.GE716@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Tue, Mar 05 2002, Zwane Mwaikambo wrote:
> 
>>On Tue, 5 Mar 2002, Martin Dalecki wrote:
>>
>>
>>>- Disable configuration of the task file stuff. It is going to go away
>>>   and will be replaced by a truly abstract interface based on
>>>   functionality and *not* direct mess-up of hardware.
>>>
>>Could you elaborate just a tad on that.
>>
> 
> While the taskfile interface is very down-to-basics and a bit extreme
> in one end, it's also very useful for eg vendors doing testing and
> certification. So in that respect it's pretty powerful, I hope Martin
> isn't just planning a stripped down interface akin to what we have in
> 2.4 and earlier.

No quite my plan is:

1. Rip it off.
2. Reimplement stuff if and only if someone really shows pressure
for using it.

The "command parsing" excess is certainly going to go.

