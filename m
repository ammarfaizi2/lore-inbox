Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317114AbSFBHBc>; Sun, 2 Jun 2002 03:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317133AbSFBHBb>; Sun, 2 Jun 2002 03:01:31 -0400
Received: from [195.63.194.11] ([195.63.194.11]:29715 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317114AbSFBHBa>; Sun, 2 Jun 2002 03:01:30 -0400
Message-ID: <3CF9B4CC.7020205@evision-ventures.com>
Date: Sun, 02 Jun 2002 08:01:48 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Anthony Spinillo <tspinillo@linuxmail.org>,
        linux-kernel@vger.kernel.org
Subject: Re: INTEL 845G Chipset IDE Quandry
In-Reply-To: <Pine.SOL.4.30.0206020318090.29792-100000@mion.elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
>>Alan,
>>
>>This is one of the versions of INTEL which has extra bandwidth if you
>>want
>>wanted to the async IO.  Meaning the device could be set faster than the
>>host when reading from the host.  However when writing to the host the
>>device "must" be set to match.  The buffer is not capable of safely
>>handling the extra push.
>>
>>So in 2.4 we will properly time the host, unlike 2.5 which has elected
>>to overdrive the hardware.
> 
> 
> Only in piix driver (Intel & Efar) and user have to explicitly compile
> support for it, it have nothing to do with kernel version and everything
> with driver version.
> 
> 
>>The effect is the following.  "LINUS are you listening?"
> 
> 				 ^^^^^^^^^^^^^^^^^^^^^^^^
> Andre, you forgot to cc Linus ;)
> 
> 
>>Ultra DMA 100 uses 4 data clocks to transfer "X" amount of data.
>>Ultra DMA 133 uses 3 data clocks to transfer "X" amount of data.
>>
>>So if a bad host trys to push the limits, it ends up missing a data
>>strobe and the DATA goes away quietly without warning.  NICE!
>>
>>Maybe now people will understand why 2.5 is falling apart and it is not
>>Martin's fault.  He is just getting bad information and bad patches.
> 
> 
> Poor Marcin, he is so misinformed by bad people trying to spoil ATA stuff.
> 
> Bad patches? Who is the bad guy making the bad patches?
> Let me guess, it is Vojtech removing others people copyrighted "sick
> timing tables". Or maybe it is Jens doing at least TCQ?
> Or maybe it is me... etc.
> 
> 
>>He actual has nearly the same model I was working on to use fucntion
> 
> 
> It is really funny... but some people read code and know facts...
> 
> 
>>pointers in the style of "MiniPort (tm)".  I will explain why this is
>>desired later.
> 
> 
> in Q4 I guess

Of year 2010 - remember learning proper C will take him time.
Becouse I never ever saw any code contributed by him
despite the fact that I'm still open for patches, as
I have told him upon request.
Once exception was a broken patch which even didn't
compile and couldn't solve the problem it was
proclaiming to solve.

