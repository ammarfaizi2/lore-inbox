Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310832AbSCHMiY>; Fri, 8 Mar 2002 07:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310831AbSCHMiO>; Fri, 8 Mar 2002 07:38:14 -0500
Received: from [195.63.194.11] ([195.63.194.11]:43268 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S310828AbSCHMiF>; Fri, 8 Mar 2002 07:38:05 -0500
Message-ID: <3C88B049.5030906@evision-ventures.com>
Date: Fri, 08 Mar 2002 13:36:25 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH][2.5] BUG check in elevator.c:237
In-Reply-To: <Pine.LNX.4.44.0203081350190.5383-100000@netfinity.realnet.co.sz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> On Fri, 8 Mar 2002, Martin Dalecki wrote:
> 
> 
>>Please let me elaborate a bit on this, to give you may be
>>some hints about where to look for an actual solution of
>>the problem:
>>
> 
> Thanks for taking the time to explain.
> 
> 
>>However for cd-rom there are commands, which can
>>take quite a long time. Therefore there is the possiblity there
>>to provide a polling function, which will be engaged after the
>>interrupt happens in the above function:
>>
> 
> So are you suggesting perhaps that we change the request servicing to 
> polling? I'm a bit confused as to how this would fit in with 

At lest we should change the way the transition between intr
controlled mode and polling is done.

> cdrom_decode_status (which in this case is called from the read_intr). You 
> might need to whip out a larger clue stick ;)

Well if your error is deterministically reproducable, it's
quite propably I would dare to have a look after it.
Could you just explain how to trigger it (Unfortunately I have
already deleted yours mail about this...)


