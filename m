Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310737AbSCHIhB>; Fri, 8 Mar 2002 03:37:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310738AbSCHIgv>; Fri, 8 Mar 2002 03:36:51 -0500
Received: from [195.63.194.11] ([195.63.194.11]:785 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S310737AbSCHIgh>;
	Fri, 8 Mar 2002 03:36:37 -0500
Message-ID: <3C8877D7.2020708@evision-ventures.com>
Date: Fri, 08 Mar 2002 09:35:35 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: arjan@fenrus.demon.nl
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Submitting PROMISE IDE Controllers Driver Patch
In-Reply-To: <200203080823.g288NC514338@fenrus.demon.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arjan@fenrus.demon.nl wrote:
> In article <3C88742A.4090804@evision-ventures.com> you wrote:
> 
>>Uhh oh, that's actually interresting and you are right on this point.
>>One should just add the functionality. If you dare to wait the weekend
>>it will happen in 2.5 ;-). Or of you care your self, then plase
>>have a look at the following code in 2.5.6-pre3 in ide-pci:
>>
> 
> Ehm. Linux *needs* to see the controller as IDE controller in order to
> support the raid. see pdcraid.c. It layers on top of the IDE layer
> to operate.

Please look closer at my posting. I just think, that since there
are apparently no tru hardware raid devices out there it would
be sufficient to expand the detection code to not ignore
RAID class devices at all. This would just prevent
us from having two different entries in the
device detection list. Not much more involved I think.

