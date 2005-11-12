Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932506AbVKLVxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506AbVKLVxI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 16:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbVKLVxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 16:53:08 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:36625 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932507AbVKLVxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 16:53:07 -0500
Date: Sat, 12 Nov 2005 22:53:04 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Michael Buesch <mbuesch@freenet.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linuv 2.6.15-rc1
Message-ID: <20051112215304.GB21448@stusta.de>
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org> <200511122145.38409.mbuesch@freenet.de> <Pine.LNX.4.64.0511121257000.3263@g5.osdl.org> <200511122237.17157.mbuesch@freenet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511122237.17157.mbuesch@freenet.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2005 at 10:37:16PM +0100, Michael Buesch wrote:
> On Saturday 12 November 2005 22:00, you wrote:
> > 
> > On Sat, 12 Nov 2005, Michael Buesch wrote:
> > > 
> > > Latest GIT tree does not boot on my G4 PowerBook.
> > 
> > What happens if you do
> > 
> > 	make ARCH=powerpc
> > 
> > and build everything that way (including the "config" phase)?
> 
> I did
> make mrproper
> copy the .config over again
> make ARCH=powerpc menuconfig
> exit and save from menuconfig
> make ARCH=powerpc
> 
> The result of the build is:
> 
>   CHK     include/linux/version.h
>   CHK     include/linux/compile.h
>   CHK     usr/initramfs_list
>   GEN     .version
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> arch/powerpc/kernel/built-in.o: In function `platform_init':
> : undefined reference to `prep_init'
> arch/powerpc/kernel/built-in.o:(__ksymtab+0x4d8): undefined reference to `ucSystemType'
> arch/powerpc/kernel/built-in.o:(__ksymtab+0x4e0): undefined reference to `_prep_type'
> make: *** [.tmp_vmlinux1] Error 1

Please send your .config .

> Greetings Michael.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

