Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313238AbSDQIut>; Wed, 17 Apr 2002 04:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313771AbSDQIus>; Wed, 17 Apr 2002 04:50:48 -0400
Received: from [195.63.194.11] ([195.63.194.11]:15891 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313238AbSDQIus>; Wed, 17 Apr 2002 04:50:48 -0400
Message-ID: <3CBD28D1.6070702@evision-ventures.com>
Date: Wed, 17 Apr 2002 09:48:33 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Sebastian Droege <sebastian.droege@gmx.de>
CC: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IDE TCQ #4
In-Reply-To: <20020415125606.GR12608@suse.de>	<02db01c1e498$7180c170$58dc703f@bnscorp.com>	<20020416102510.GI17043@suse.de>	<20020416200051.7ae38411.sebastian.droege@gmx.de>	<20020416180914.GR1097@suse.de> <20020416204329.4c71102f.sebastian.droege@gmx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian Droege wrote:
> On Tue, 16 Apr 2002 20:09:14 +0200
> Jens Axboe <axboe@suse.de> wrote:
> 
> 
>>On Tue, Apr 16 2002, Sebastian Droege wrote:
>>
>>>Hi,
>>>just one short question:
>>>My hda supports TCQ but my hdb doesn't
>>>Is it safe to enable TCQ in kernel config?
>>
>>yes, should be safe.
>>
>>-- 
>>Jens Axboe
>>
> 
> Ok it really works ;)
> But there's another problem in 2.5.8 with ide patches until 37 applied (they don't appear with 2.5.8 and ide patches until 35), the unexpected interrupts (look at the relevant dmesg output at the bottom). They appear with and without TCQ enabled.
> If you need more informations, just ask :)

They are not a problem. They are just diagnostics for us and will
go away at some point in time.

