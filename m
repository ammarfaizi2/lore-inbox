Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292681AbSCIMlu>; Sat, 9 Mar 2002 07:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292678AbSCIMlk>; Sat, 9 Mar 2002 07:41:40 -0500
Received: from [195.63.194.11] ([195.63.194.11]:20235 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S292664AbSCIMlW>; Sat, 9 Mar 2002 07:41:22 -0500
Message-ID: <3C8A02A0.8020001@evision-ventures.com>
Date: Sat, 09 Mar 2002 13:40:00 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Andre Hedrick <andre@linuxdiskcert.org>
CC: Luigi Genoni <kernel@Expansa.sns.it>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.6 IDE oops with i810 chipset
In-Reply-To: <Pine.LNX.4.10.10203080831480.504-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:
> On Fri, 8 Mar 2002, Martin Dalecki wrote:
> 
> 
>>Luigi Genoni wrote:
>>
>>>Due to a lack of time i tried just 2.5.5, which worked very well.
>>>I get the oops while initializing the IDE controller, just after
>>>
>>>hdc: LTN485, ATAPI CD/DVD-ROM drive
>>>
>>>and before the expected:
>>>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
>>>
>>>
>>OK thank you very much this helps. I will actually have to fake the
>>detection on my system to think it's the same as yours...
>>One thing for sure: it's not dircetly inside the
>>PCI host initialization, so I wonder why this problem
>>doesn't occur to more people.
>>
> 
> You will soon learn about the way ATAPI removable media violate the rules
> of how the maintain their status and signal lines.  However you already
> knew this information as I am wasting electrons

I think an oops is rather good sign here, since it is
more of a sign of a trival typo mistake or therelike.
If the system where actually going into boot mode and starting
to be flaky then, then I would see more serious trouble...

