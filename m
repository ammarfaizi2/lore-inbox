Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbUCITvY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 14:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbUCITvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 14:51:21 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:37371 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262110AbUCITuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 14:50:46 -0500
Date: Tue, 9 Mar 2004 20:50:37 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Lee Howard <faxguy@howardsilvan.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: error compiling 2.6.3
Message-ID: <20040309195037.GM14833@fs.tum.de>
References: <20040309192252.GG11378@bilbo.x101.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040309192252.GG11378@bilbo.x101.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2004 at 11:22:52AM -0800, Lee Howard wrote:
> ....
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   CC      init/do_mounts.o
>   CC      init/do_mounts_rd.o
>   CC      init/do_mounts_initrd.o
>   LD      init/mounts.o
>   CC      init/initramfs.o
>   LD      init/built-in.o
>   HOSTCC  usr/gen_init_cpio
>   CPIO    usr/initramfs_data.cpio
>   GZIP    usr/initramfs_data.cpio.gz
>   AS      usr/initramfs_data.o
> /tmp/ccFjeWhS.s: Assembler messages:
> /tmp/ccFjeWhS.s:3: Error: Unknown pseudo-op:  `.incbin'
> make[1]: *** [usr/initramfs_data.o] Error 1
> make: *** [usr] Error 2
> [root@bilbo linux-2.6.3]# 

Please update your binutils.

Documentation/Changes lists version 2.12 as the minimum required 
version.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

