Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310839AbSCHMvO>; Fri, 8 Mar 2002 07:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310841AbSCHMvE>; Fri, 8 Mar 2002 07:51:04 -0500
Received: from [195.63.194.11] ([195.63.194.11]:56324 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S310839AbSCHMvB>; Fri, 8 Mar 2002 07:51:01 -0500
Message-ID: <3C88B35C.20202@evision-ventures.com>
Date: Fri, 08 Mar 2002 13:49:32 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH][2.5] BUG check in elevator.c:237
In-Reply-To: <Pine.LNX.4.44.0203081426060.5383-100000@netfinity.realnet.co.sz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> On Fri, 8 Mar 2002, Martin Dalecki wrote:
> 
>>>So are you suggesting perhaps that we change the request servicing to 
>>>polling? I'm a bit confused as to how this would fit in with 
>>>
>>At lest we should change the way the transition between intr
>>controlled mode and polling is done.
>>
> 
> To something like what some other subsystem  drivers do? ie
> 
> interrupt triggered
> ISR hands off work to a BH
> 
> Or is that different from what you had in mind?

No this is precisely what I had in mind.
Network adapter and SCSI drivers are good points where
to have a look.

