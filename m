Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267310AbTBKHSA>; Tue, 11 Feb 2003 02:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265517AbTBKHSA>; Tue, 11 Feb 2003 02:18:00 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:30925 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267310AbTBKHR6>; Tue, 11 Feb 2003 02:17:58 -0500
Date: Tue, 11 Feb 2003 08:27:41 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: James Lamanna <james.lamanna@appliedminds.com>
Cc: "'Linus Torvalds'" <torvalds@transmeta.com>, shaggy@austin.ibm.com,
       jfs-discussion@oss.software.ibm.com,
       "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.60: JFS no longer compiles with gcc 2.95
Message-ID: <20030211072741.GF17128@fs.tum.de>
References: <20030210204651.GE17128@fs.tum.de> <022f01c2d14d$71b46550$39140b0a@amthinking.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <022f01c2d14d$71b46550$39140b0a@amthinking.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2003 at 01:43:26PM -0800, James Lamanna wrote:
> >>> This broke the compilation with gcc 2.95: 
> <--  snip  --> 
> ... 
>   gcc -Wp,-MD,fs/jfs/.super.o.d -D__KERNEL__ -Iinclude -Wall 
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
> -pipe -mpreferred-stack-boundary=2 -march=k6 
> -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include  
> -D_JFS_4K  -DKBUILD_BASENAME=super -DKBUILD_MODNAME=jfs -c -o 
> fs/jfs/super.o fs/jfs/super.c 
> fs/jfs/super.c: In function `jfs_fill_super': 
> fs/jfs/super.c:335: parse error before `)' 
> make[2]: *** [fs/jfs/super.o] Error 1 
> <--  snip  --> 
> 
> Curious as to what gcc 2.95 version you are using.
> Seems to compile fine with:
> gcc 2.95.4 20011002

I'm using the same gcc. I should have said that I'm compiling with 
CONFIG_JFS_DEBUG. Without CONFIG_JFS_DEBUG it indeed compiles fine.

> --James

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

