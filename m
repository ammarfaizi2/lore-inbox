Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313568AbSDQLov>; Wed, 17 Apr 2002 07:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313569AbSDQLou>; Wed, 17 Apr 2002 07:44:50 -0400
Received: from [195.63.194.11] ([195.63.194.11]:57349 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313568AbSDQLou>; Wed, 17 Apr 2002 07:44:50 -0400
Message-ID: <3CBD519F.7080207@evision-ventures.com>
Date: Wed, 17 Apr 2002 12:42:39 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Sebastian Droege <sebastian.droege@gmx.de>
CC: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IDE TCQ #4
In-Reply-To: <20020415125606.GR12608@suse.de>	<02db01c1e498$7180c170$58dc703f@bnscorp.com>	<20020416102510.GI17043@suse.de>	<20020416200051.7ae38411.sebastian.droege@gmx.de>	<20020416180914.GR1097@suse.de>	<20020416204329.4c71102f.sebastian.droege@gmx.de>	<3CBD28D1.6070702@evision-ventures.com> <20020417132852.4cf20276.sebastian.droege@gmx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.
> when I cat /proc/ide/ide1/hdc/identify I get 2 unexpected interrupts
> hdc and hdd are both cdrom drives (accessed via scsi-emulation if relevant) 
 > but the problem shows up only with hdc

Duh oh... This is actually a good hint. I will look after
this.

> 
> and maybe a third problem ;)
> in /proc/ide/ide0/hda/tcq there is written:
> DMA status: not running

This is harmless it just shows that there was no DMA transfer in flight the
time you have cat-ed this file.

> but DMA is explicitly enabled by hdparm and shows up in /proc/ide/ide0/hda/settings
> 
> I'll do some more testings later the day

