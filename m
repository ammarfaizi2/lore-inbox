Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313440AbSC2NvJ>; Fri, 29 Mar 2002 08:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313441AbSC2Nu7>; Fri, 29 Mar 2002 08:50:59 -0500
Received: from [195.63.194.11] ([195.63.194.11]:36369 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313440AbSC2Nuw>; Fri, 29 Mar 2002 08:50:52 -0500
Message-ID: <3CA470D8.3080103@evision-ventures.com>
Date: Fri, 29 Mar 2002 14:49:12 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.7 IDE 27
In-Reply-To: <Pine.LNX.4.44.0203280959520.1460-100000@blue1.dev.mcafeelabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> On Thu, 28 Mar 2002, Martin Dalecki wrote:
> 
> 
>>Thu Mar 21 03:17:48 CET 2002 ide-clean-27
>>
>>- Make for less terse error messages in ide-tape.c.
>>
>>- Replaced all timecomparisions done by hand with all the proper timer_after()
>>   commands.
>>
>>- Remove the drive niec1 mechanisms alltogether. There are several reasons for
>>   this:
> 
> 
> I did not have the time to test it Martin but looking at the code i'm
> pretty confident that this is the cause of the ide_set_handler()/timer
> problem on my box ...

Does it mean that you think that my guess was right?

