Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291397AbSBHEF1>; Thu, 7 Feb 2002 23:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291400AbSBHEFU>; Thu, 7 Feb 2002 23:05:20 -0500
Received: from nycsmtp1out.rdc-nyc.rr.com ([24.29.99.226]:47519 "EHLO
	nycsmtp1out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S291397AbSBHEFI>; Thu, 7 Feb 2002 23:05:08 -0500
Message-ID: <3C634E72.4070002@nyc.rr.com>
Date: Thu, 07 Feb 2002 23:05:06 -0500
From: John Weber <weber@nyc.rr.com>
Organization: WorldWideWeber
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: linux 2.5.4-pre3 and IDE changes
In-Reply-To: <fa.c2cp66v.1dgedgb@ifi.uio.no> <fa.10ej114v.oj62bd@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Skip Ford wrote:

> John Weber wrote:
> 
>>The address member of struct scatterlist appears to have been changed to 
>>dma_address.
>>
>>A simple s/\.address/\.dma_address/ should fix this compile error.
>>
>>ide-dma.c: In function `ide_raw_build_sglist':
>>ide-dma.c:269: structure has no member named `address'
>>ide-dma.c:276: structure has no member named `address'
>>make[3]: *** [ide-dma.o] Error 1
>>make[3]: Leaving directory `/usr/src/linux-2.5.4/drivers/ide'
>>make[2]: *** [first_rule] Error 2
>>make[2]: Leaving directory `/usr/src/linux-2.5.4/drivers/ide'
>>make[1]: *** [_subdir_ide] Error 2
>>make[1]: Leaving directory `/usr/src/linux-2.5.4/drivers'
>>make: *** [_dir_drivers] Error 2
>>
> 
> This is the patch that Jens posted, though he posted it before this
> kernel was even released.  His post said it fixed a compile error
> in pre2, but pre2 compiled fine.  It _does_ fix the compile error in
> pre3 though.


I thought I was going crazy.  Thanks!

What is the dma_address member for?




