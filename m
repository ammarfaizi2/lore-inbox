Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292749AbSCIN0m>; Sat, 9 Mar 2002 08:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292751AbSCIN0d>; Sat, 9 Mar 2002 08:26:33 -0500
Received: from [195.63.194.11] ([195.63.194.11]:34315 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S292749AbSCIN0X>; Sat, 9 Mar 2002 08:26:23 -0500
Message-ID: <3C8A0D38.2000901@evision-ventures.com>
Date: Sat, 09 Mar 2002 14:25:12 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Kelsey Hudson <khudson@compendium-tech.com>
CC: Arjan van de Ven <arjan@fenrus.demon.nl>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Submitting PROMISE IDE Controllers Driver Patch
In-Reply-To: <Pine.LNX.4.44.0203081124580.20142-100000@sol.compendium-tech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kelsey Hudson wrote:
> On Fri, 8 Mar 2002, Arjan van de Ven wrote:
> 
> 
>>On Fri, Mar 08, 2002 at 09:35:35AM +0100, Martin Dalecki wrote:
>>
>>>Please look closer at my posting. I just think, that since there
>>>are apparently no tru hardware raid devices out there it would
>>>be sufficient to expand the detection code to not ignore
>>>RAID class devices at all. This would just prevent
>>>us from having two different entries in the
>>>device detection list. Not much more involved I think.
>>>
>>There's one tiny glitch: there are exactly 2 "real" raid devices out there
>>(that I know of at least). But anyway, a "don't look at" list will be
>>MUCH shorter than a "look also at" list.
>>
> 
> I know of two Promise cards that do hardware raid, and I know there are 
> several cards available from 3Ware that also do hardware ata raid

Please don't look at the disks you plug into the controller.
Please look at the interface the controller is exposing to the system.
In esp. I know that there is 3Ware linux IDE RAID driver there.
But the interface it is exposing falls under the SCSI host adapter
category.

