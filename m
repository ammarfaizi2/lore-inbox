Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261290AbVCGTQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbVCGTQx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 14:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbVCGTP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 14:15:59 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:50692 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261305AbVCGTOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 14:14:44 -0500
Date: Mon, 7 Mar 2005 20:14:42 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jan Prunk <janprunk@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: debian kernel 2.4.29
Message-ID: <20050307191442.GE3170@stusta.de>
References: <BAY24-F18AB80179386A2AAB4DCEAD85F0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY24-F18AB80179386A2AAB4DCEAD85F0@phx.gbl>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2005 at 12:48:01PM +0000, Jan Prunk wrote:

> Hello !

Hi Jan!

> I tried to compile kernel 2.4.29 on a debian PARISC machine Gecko 712/60, 
> using PA7100LC processor.
> I executed command to build a custom debian kernel:
> fakeroot make-kpkg --revision=custom.1.0 kernel_image
> 
> The kernel config file is available here:
> http://212.18.59.124/kernel-2.4.29/config
> 
> The errors in the kernel are following:
> signal.c:66: warning: passing arg 1 of `__put_kernel_asm64' makes
> integer from pointer without a cast
> signal.c:66: warning: passing arg 1 of `__put_user_asm64' makes integer
> from pointer without a cast
> gcc -D__ASSEMBLY__ -traditional -D__KERNEL__
> -I/usr/src/linux-2.4.29/include  -c -o hpmc.o hpmc.S
> gcc -D__ASSEMBLY__ -traditional -D__KERNEL__
> -I/usr/src/linux-2.4.29/include  -c -o real2.o real2.S
> real2.S: Assembler messages:
> real2.S:126: Error: too many positional arguments
> make[2]: *** [real2.o] Error 1
> make[2]: Leaving directory `/usr/src/linux-2.4.29/arch/parisc/kernel'
> make[1]: *** [_dir_arch/parisc/kernel] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.4.29'
> make: *** [stamp-build] Error 2
> 
> If you happen to know how to make this work, I appreciate a copy of your 
> email to my address.

Most likely, ftp.kernel.org 2.4 kernels don't work on HPPA.

kernel-source-2.4.27 plus kernel-patch-2.4.27-hppa might help you to get 
a working kernel.

> Regards, Jan Prunk

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

