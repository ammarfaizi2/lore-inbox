Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315798AbSEEA4s>; Sat, 4 May 2002 20:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315799AbSEEA4r>; Sat, 4 May 2002 20:56:47 -0400
Received: from [195.63.194.11] ([195.63.194.11]:29450 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315798AbSEEA4r>; Sat, 4 May 2002 20:56:47 -0400
Message-ID: <3CD4748D.30301@evision-ventures.com>
Date: Sun, 05 May 2002 01:53:49 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Tim Schmielau <tim@physik3.uni-rostock.de>
CC: Andreas Dilger <adilger@turbolabs.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.13 IDE 50
In-Reply-To: <Pine.LNX.4.33.0205031949010.5617-100000@gans.physik3.uni-rostock.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Tim Schmielau napisa?:
>>- Fix wrong usage of time_after in ide.c. This should cure the drive 
>>seek
>>   timeout problems some people where expierencing. This was clarified 
>>to me by
>>   Bartek, who apparently checked whatever the actual code is consistent 
>>with the comments in front of it. Thank you Bartlomiej Zolnierkiewicz.
>>
>>   I think now that we should have time_past(xxx) in <linux/timer.h>.
> 
> 
> What would you suppose time_past(xxx) to do?


Taking only a single parameter and telling whatever jiffies is bigger
then it. Just that. Becouse if you grep for time_after or time_before
you would realize immediately that nearly all of them take
the variable jiffies as parameter.


