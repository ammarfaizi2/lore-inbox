Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316910AbSEVJpf>; Wed, 22 May 2002 05:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316911AbSEVJpd>; Wed, 22 May 2002 05:45:33 -0400
Received: from [195.63.194.11] ([195.63.194.11]:54030 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316910AbSEVJp2>; Wed, 22 May 2002 05:45:28 -0400
Message-ID: <3CEB59E2.7020307@evision-ventures.com>
Date: Wed, 22 May 2002 10:42:10 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] duplicate clock calculation code in 3 IDE drivers
In-Reply-To: <20020522093013.GD312@pazke.ipt> <20020522114206.D31145@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Vojtech Pavlik napisa?:
> On Wed, May 22, 2002 at 01:30:13PM +0400, Andrey Panin wrote:
> 
>>Hi,
>>
>>now it is more interesting patch. AMD, PIIX and VIA IDE drivers contain
>>some duplicated code for (amd|piix|via)_clock calculation. Attached
>>patch moves this code into one function in ata-timing.c file.
>>
>>Please take a look at it.
> 
> 
> Looks quite OK - though it'd be better if "system_bus_speed" already
> could be giving these reasonable values - this way we could get rid of
> the (amd|piix|via)_clock variables altogether.


Yes indeed this would be the "kings road".

Any one of you who cares enough?

