Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316579AbSEUUEJ>; Tue, 21 May 2002 16:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316581AbSEUUEI>; Tue, 21 May 2002 16:04:08 -0400
Received: from [195.63.194.11] ([195.63.194.11]:60169 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316579AbSEUUEH>; Tue, 21 May 2002 16:04:07 -0400
Message-ID: <3CEA995A.50007@evision-ventures.com>
Date: Tue, 21 May 2002 21:00:42 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: Meelis Roos <mroos@linux.ee>, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@suse.de>
Subject: Re: 2.5.17: ide & ext2 unresolved symbols in modules
In-Reply-To: <Pine.GSO.4.43.0205212200500.19324-100000@romulus.cs.ut.ee> <3CEA9C42.B2871594@zip.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Andrew Morton napisa?:
> Meelis Roos wrote:
> 
>>depmod: *** Unresolved symbols in /lib/modules/2.5.17/kernel/drivers/ide/ide-disk.o
>>depmod:         udma_tcq_enable
> 
> 
> Not sure.

Fixed in IDE 65. It was indeed missing. (Modulo the fact that udma_tcq_enable
and udma_enable should be merged.)


> 
> 
>>depmod: *** Unresolved symbols in /lib/modules/2.5.17/kernel/drivers/ide/ide-mod.o
>>depmod:         blk_get_request
> 
> 
> Needs exporting.  I'll let Jens do that...
> 
> 
>>depmod: *** Unresolved symbols in /lib/modules/2.5.17/kernel/fs/ext2/ext2.o
>>depmod:         write_mapping_buffers
> 
> 
> Needs to be exported.  I'll fix that.
> 
> Thanks.
> 
> -
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 



-- 
- phone: +49 214 8656 283
- job:   eVision-Ventures AG, LEV .de (MY OPINIONS ARE MY OWN!)
- langs: de_DE.ISO8859-1, en_US, pl_PL.ISO8859-2, last ressort: ru_RU.KOI8-R

