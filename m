Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310232AbSCKRFM>; Mon, 11 Mar 2002 12:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310222AbSCKREw>; Mon, 11 Mar 2002 12:04:52 -0500
Received: from [195.63.194.11] ([195.63.194.11]:22026 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S310219AbSCKREm>; Mon, 11 Mar 2002 12:04:42 -0500
Message-ID: <3C8CE34B.4030800@evision-ventures.com>
Date: Mon, 11 Mar 2002 18:03:07 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.6 IDE 19
In-Reply-To: <E16kT8L-00014f-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>>You are claiming this repeatidly. But please just send me the f*cking
>>strace and I will beleve you. Or point me at the corresponding docs.
>>
> 
> You tell me how to strace the bios for one

OK, so there is no f*cking magic utility from IBM to do suspend
of MicroDrives under linux through the TASKFILE interface at all
as you have climed!

>>I see no special purpose Win2000 microdrive drivers on IBM.
>>
> 
> No because Microsoft implement the bloody standard in the first place. It

Hack, then tell me what I'm at?

> works very nicely in MS systems. It works ok in 2.4.18 except with a couple
> of boxes that don't poke the drive from the APM layer (eg IBM PC110)
> 
> 
>>And I suppose you don't even *own* an IBM MicroDrive. And please
> If you wish to call me a liar, why not do so directly ?

If I wished this I would just do. Trust me!

>>1. How is Win2000 going to work then?
>>
> 
> Because its standards compliant. It wasnt written by a half clued wannabe
> who has never read the manuals and can do nothing but call people who have
> a "liar". And a standards compliant implementation does all the right power

Andre Hedrick will may kill you... However apparently we agree that
there is something wrong with the current driver.

> management commands. Win 98 didnt quite get it right and you'll find one
> of the updates addresses IDE problems. Ironically fixing the same flush
> cache and shut down politely problem you plan to break in Linux

No, the problem *is there* Pavel just attempts to FIX IT and I do
nothing but supporting him on this. You can hardly claim that
he hooks the whole up on the wrong place...

> For the other reason - they are better written. But a driven can be both
> well written and correct. Its quite apparently you don't care about "correct".

Wrong I care. But I still didn't get too this right now.

> If your design is not rigorously following the standard (plus the usual
> amount of vendor got it wrong slop) then bad things will occur.

Trivially right.

> I'm not arguing that Andre's code is good, or that it doesn't need
> some serious redesign. I'm just suggesting it would be a good idea if whoever
> wrote it new what the hell the were doing, or at least spent the time to
> understand the ATA documentation and implement it.

So what the heck. Do you thing it will happen overnight!?
Just see how much time it took to get the init tables into
some reasonable shape... and the road is still ahead on the
simple issue of getting them out of ide-pci.c finally!!!
There is only one way of cooperation here - sharing even not quite finished but
not broken code - and I still hold up that this is the case with
Pavels code.

> Now contrary to your claim I do have an ibm microdrive, do you have the
> ATA specs, have you ever read them ? I really doubt it.

It wasn't a claim but just a suspiction. So this is cleared.
But apparently there is no special IBM command using taskfile
to do magic things to it. So therefore it's still valid:
your example was indeed a mock-up.

For your information: I have read the standard papers and comments
to them. But the application notes from IBM and actual code
from different operating systems gives a much better formal
description of what is needed anyway. Or are you going to claim
that narrative languaue is more precise then actual C code?

