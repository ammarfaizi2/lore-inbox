Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267471AbTBUO7g>; Fri, 21 Feb 2003 09:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267473AbTBUO7g>; Fri, 21 Feb 2003 09:59:36 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:50627 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267471AbTBUO7e>; Fri, 21 Feb 2003 09:59:34 -0500
Date: Fri, 21 Feb 2003 16:09:35 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Alan Cox <alan@redhat.com>, James Simmons <jsimmons@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.62-ac1
Message-ID: <20030221150935.GO531@fs.tum.de>
References: <200302202233.h1KMX8408821@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302202233.h1KMX8408821@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2003 at 05:33:08PM -0500, Alan Cox wrote:

>...
> Linux 2.5.62-ac1
>...
> o	FBdev updates					(James Simmons)
>...

FYI:

This causes the followig compile error (more error messages in this file
skipped):

<--  snip  -->

...
  gcc -Wp,-MD,drivers/video/aty/.mach64_ct.o.d -D__KERNEL__ -Iinclude 
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
-fno-common -pipe -mpreferred-stack-boundary=2 -march=k6 
-Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    
-DKBUILD_BASENAME=mach64_ct -DKBUILD_MODNAME=atyfb -c -o 
drivers/video/aty/mach64_ct.o drivers/video/aty/mach64_ct.c
drivers/video/aty/mach64_ct.c: In function `aty_dsp_gt':
drivers/video/aty/mach64_ct.c:51: structure has no member named 
`xclk_post_div_real'
drivers/video/aty/mach64_ct.c:60: structure has no member named 
`fifo_size'
drivers/video/aty/mach64_ct.c:67: structure has no member named 
`fifo_size'
drivers/video/aty/mach64_ct.c:69: structure has no member named 
`page_size'
drivers/video/aty/mach64_ct.c:86: structure has no member named 
`dsp_loop_latency'
...
make[3]: *** [drivers/video/aty/mach64_ct.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

