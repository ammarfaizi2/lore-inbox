Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310754AbSCHJPn>; Fri, 8 Mar 2002 04:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310755AbSCHJPb>; Fri, 8 Mar 2002 04:15:31 -0500
Received: from [195.63.194.11] ([195.63.194.11]:47377 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S310754AbSCHJPV>; Fri, 8 Mar 2002 04:15:21 -0500
Message-ID: <3C8880EF.5030602@evision-ventures.com>
Date: Fri, 08 Mar 2002 10:14:23 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Arjan van de Ven <arjan@fenrus.demon.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Submitting PROMISE IDE Controllers Driver Patch
In-Reply-To: <200203080823.g288NC514338@fenrus.demon.nl> <3C8877D7.2020708@evision-ventures.com> <20020308085028.A14375@fenrus.demon.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Fri, Mar 08, 2002 at 09:35:35AM +0100, Martin Dalecki wrote:
> 
>>Please look closer at my posting. I just think, that since there
>>are apparently no tru hardware raid devices out there it would
>>be sufficient to expand the detection code to not ignore
>>RAID class devices at all. This would just prevent
>>us from having two different entries in the
>>device detection list. Not much more involved I think.
>>
> 
> There's one tiny glitch: there are exactly 2 "real" raid devices out there
> (that I know of at least). But anyway, a "don't look at" list will be
> MUCH shorter than a "look also at" list.

Would you dare to tell me which those are? And are you sure
they don't expose themself as SCSI hosts to the system on PCI?

