Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292659AbSCIU7i>; Sat, 9 Mar 2002 15:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292919AbSCIU73>; Sat, 9 Mar 2002 15:59:29 -0500
Received: from [195.63.194.11] ([195.63.194.11]:46092 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S292659AbSCIU7S>; Sat, 9 Mar 2002 15:59:18 -0500
Message-ID: <3C8A7768.3090709@evision-ventures.com>
Date: Sat, 09 Mar 2002 21:58:16 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
CC: lkml <linux-kernel@vger.kernel.org>, torvalds@transmeta.com
Subject: Re: 2.5.6-pre3 boot hangs in ide probing
In-Reply-To: <3C89C3D4.3070004@wanadoo.fr> <3C8A09BD.7080103@evision-ventures.com> <3C8A1E35.7030602@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Rousselet wrote:
> Martin Dalecki wrote:
> 
>> Pierre Rousselet wrote:
>>
>>> The motherboard is abit BE6 (4 ide, piix and hpt366) with a pIII 
>>> coppermine.
>>> For reference below is dmesg with a booting 2.5.6-pre2.
>>>
>>
>> I observed the same on pre3. But the bug is not ide related,
>> since the plain ide patches applied on top of pre2 just worked.
>>
>> (I happen to own the same hpt366 card as you.)
> 
> 
> Thanks. 2.5.6 actually boots cleanly.
> 
> Pierre

Unfortunately my Athlon based system on 2.5.6 boots,
but I get tons of messages about unresolved symbols from
particular modules during X startup - which is a sign
for the fact that the recent memmory management changes
found between pre2 and pre3 are still hossed.
My intel based notebook however appears to be working.
(Im of course choosing the processor type on both systems...)

