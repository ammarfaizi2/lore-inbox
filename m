Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286647AbSCKSZQ>; Mon, 11 Mar 2002 13:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285692AbSCKSZH>; Mon, 11 Mar 2002 13:25:07 -0500
Received: from [195.63.194.11] ([195.63.194.11]:62474 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S285424AbSCKSYw>; Mon, 11 Mar 2002 13:24:52 -0500
Message-ID: <3C8CF62C.3040902@evision-ventures.com>
Date: Mon, 11 Mar 2002 19:23:40 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.6 IDE 19
In-Reply-To: <E16kTdQ-0001AB-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>>OK, so there is no f*cking magic utility from IBM to do suspend
>>of MicroDrives under linux through the TASKFILE interface at all
>>as you have climed!
>>
> 
> I wrote some bits for the PC110 to work around the APM problem.
> 
> 
>>>No because Microsoft implement the bloody standard in the first place. It
>>>
>>Hack, then tell me what I'm at?
>>
> 
> I'd hope implementing the bloody standard. 
> 
> 
>>Andre Hedrick will may kill you... However apparently we agree that
>>there is something wrong with the current driver.
>>
> 
> Yes. There is an awful lot wrong
> 
> 
>>It wasn't a claim but just a suspiction. So this is cleared.
>>But apparently there is no special IBM command using taskfile
>>to do magic things to it. So therefore it's still valid:
>>your example was indeed a mock-up.
>>
> 
> There are standard commands for power management, and for cache flush.
> 
> 
>>to them. But the application notes from IBM and actual code
>>from different operating systems gives a much better formal
>>description of what is needed anyway. Or are you going to claim
>>that narrative languaue is more precise then actual C code?
>>
> 
> That depends if the C code is right.

Not quite if it still works... or if nobody is implementing
the standard up to word, becouse for example everybody was
deriving the drivers (or let's say it clear: his TCP/IP stack)
from the same basic source code and finally the hardware adjusted
to the reality instead of the standard.
Or if the standard was in fact just an aftertought after some
"refference implementation".
And anyway it's hard to argue that code is formally tighter then
narrative. (I didn't argue whatever it's formally correct).
That's a rather trivial fact.

But anyway I think you understand those issues and it's a bit
"theoretical" in respect to the ATA stuff right now.

> Understand - I really appreciate the fact you are planning to tackle this
> its just the way it comes across on correctness or lack thereof I find a
> little alarming. Maybe I am misjudging you - if so I certainly apologise

So let's just settle on the fruitless discussions and wait and see... OK?
Peace? I was basically just alarmed by the fact that you sounded a bit
discouraging to Pavel. (BTW.> The flush part I have already just added to my
sorcebase for the parts which Pavels patch tangles... ;-)

