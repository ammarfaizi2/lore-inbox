Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbVCGRmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbVCGRmp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 12:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbVCGRmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 12:42:45 -0500
Received: from smtp-vbr12.xs4all.nl ([194.109.24.32]:15891 "EHLO
	smtp-vbr12.xs4all.nl") by vger.kernel.org with ESMTP
	id S261189AbVCGRmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 12:42:22 -0500
Date: Mon, 7 Mar 2005 18:42:13 +0100
From: Jurriaan on adsl-gate <thunder7@xs4all.nl>
To: Jan Prunk <janprunk@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: debian kernel 2.4.29
Message-ID: <20050307174213.GB629@gates.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
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
> 
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
> 
For pa-risc kernels, try the pa-risc mailinglist. Generally, vanilla
kernel sources don't compile on pa-risc. Also, the developers of the
pa-risc platform all use 2.6.x kernels. You need to get 2.6.X-paY
patches - it's all on the parisc mailinglist.

Good luck,
Jurriaan
