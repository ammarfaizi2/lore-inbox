Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266949AbSLKBVD>; Tue, 10 Dec 2002 20:21:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266952AbSLKBVD>; Tue, 10 Dec 2002 20:21:03 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:44516 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S266949AbSLKBVC>; Tue, 10 Dec 2002 20:21:02 -0500
Date: Wed, 11 Dec 2002 02:28:46 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Pete Clements <clem@clem.digital.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.51 compile fails (fs/readdir.c)
Message-ID: <20021211012846.GQ17522@fs.tum.de>
References: <200212110011.TAA11516@clem.digital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212110011.TAA11516@clem.digital.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2002 at 07:11:22PM -0500, Pete Clements wrote:
> FYI:
> 
> 
>   gcc -Wp,-MD,fs/.readdir.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iarch/i386/mach-generic -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAME=readdir -DKBUILD_MODNAME=readdir   -c -o fs/readdir.o fs/readdir.c
> fs/readdir.c: In function `filldir64':
> fs/readdir.c:242: internal error--unrecognizable insn:
> (insn 187 186 448 (set (reg/v:SI 4 %esi)
>         (asm_operands/v ("1:	movl %%eax,0(%2)
>...

This is a bug in your compiler.

Which version of gcc are you using?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

