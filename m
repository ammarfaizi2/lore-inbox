Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273877AbRJDOB4>; Thu, 4 Oct 2001 10:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273724AbRJDOBj>; Thu, 4 Oct 2001 10:01:39 -0400
Received: from rj.SGI.COM ([204.94.215.100]:47056 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S273702AbRJDOB1>;
	Thu, 4 Oct 2001 10:01:27 -0400
Message-Id: <200110041401.f94E1an22571@jen.americas.sgi.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.11-pre2-xfs 
In-Reply-To: Message from Andrey Nekrasov <andy@spylog.ru> 
   of "Thu, 04 Oct 2001 14:15:13 +0400." <20011004141513.A5421@spylog.ru> 
Date: Thu, 04 Oct 2001 09:01:36 -0500
From: Steve Lord <lord@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello.
> 
>  1. hardware Intel ISP1100 (BX/1GB RAM/IDE DISK)
>  2. kernel 2.4.11-pre2-xfs, with highmem support
> 
>  3. create ramdisk 512Mb and run "tiotest -c -f 110"

And what type of filesystems were used? I am presuming XFS.

>  4. 
>  
>  __alloc_pages: 0-order allocation failed (gfp=0x3d0/0) from c0127fe9
>  __alloc_pages: 0-order allocation failed (gfp=0x2f0/0) from c0127fe9
>  __alloc_pages: 0-order allocation failed (gfp=0x70/0) from c0127fe9
>  __alloc_pages: 0-order allocation failed (gfp=0x2f0/0) from c0127fe9
>  __alloc_pages: 0-order allocation failed (gfp=0x70/0) from c0127fe9
>  __alloc_pages: 0-order allocation failed (gfp=0x2f0/0) from c0127fe9
>  __alloc_pages: 0-order allocation failed (gfp=0x70/0) from c0127fe9
>  __alloc_pages: 0-order allocation failed (gfp=0x3f0/0) from c0127fe9
>  __alloc_pages: 0-order allocation failed (gfp=0x3f0/0) from c0127fe9
>  __alloc_pages: 0-order allocation failed (gfp=0x3f0/0) from c0127fe9
>  __alloc_pages: 0-order allocation failed (gfp=0x70/0) from c0127fe9
>  __alloc_pages: 0-order allocation failed (gfp=0x2f0/0) from c0127fe9
>  __alloc_pages: 0-order allocation failed (gfp=0x2f0/0) from c0127fe9
>  __alloc_pages: 0-order allocation failed (gfp=0x70/0) from c0127fe9

Can you map that address onto a symbol by any chance?

Steve

p.s. linux-xfs@oss.sgi.com is a good place to mail things like this,
messages posted to just linux-kernel tend to get lost in the noise.

>  
>  5. kernel compiled with gdb & have serial console.
> 
> -- 
> bye.
> Andrey Nekrasov, SpyLOG.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


