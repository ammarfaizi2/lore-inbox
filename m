Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293203AbSEIMiK>; Thu, 9 May 2002 08:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293337AbSEIMiJ>; Thu, 9 May 2002 08:38:09 -0400
Received: from [195.63.194.11] ([195.63.194.11]:10770 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S293203AbSEIMiJ>; Thu, 9 May 2002 08:38:09 -0400
Message-ID: <3CDA5ED6.9070701@evision-ventures.com>
Date: Thu, 09 May 2002 13:34:46 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cantab.net>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Bjorn Wesen <bjorn.wesen@axis.com>, Paul Mackerras <paulus@samba.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IDE 58
In-Reply-To: <20020508111256.27246@smtp.wanadoo.fr> <5.1.0.14.2.20020508192557.0409b1f0@pop.cus.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Anton Altaparmakov napisa?:
> At 11:25 08/05/02, Martin Dalecki wrote:
> 
>> Terminology in 2.5:
>> We have a host chip set or shortly a host chip. This is implementing the
>> ATA interface on the side of the motherboard.
>> The host chip is providing two channels. A primary and a secondary
>> one. To a channel we can attach two devices, however we use the term
>> drive instead in code becouse the termi device is quite overloaded with
>> meaning already. The devices are enumerated as units. That's it.
>> Far more natural then hwif hwgrp and so on. IDE is the Integrated Device
>> Electronic - the microcontroller stuff I don't care that much about.
> 
> 
> </me ignorant>Um, what about the IDE PCI cards which have 4 channels on 
> them? Like these two:
> 
> Adaptec 2400 4Ch IDE Raid Controller
> RocketRaid 404 4Ch ATA133 Raid Host Adaptor

They appear as SCSI on the host side.

