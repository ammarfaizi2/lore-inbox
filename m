Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263460AbTIHSSP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 14:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263467AbTIHSSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 14:18:15 -0400
Received: from dodge.jordet.nu ([217.13.8.142]:7586 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id S263460AbTIHSSN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 14:18:13 -0400
Subject: Re: New ATI FireGL driver supports 2.6 kernel
From: Stian Jordet <liste@jordet.nu>
To: Mika Liljeberg <mika.liljeberg@welho.com>
Cc: linux-kernel@vger.kernel.org, dri-users@lists.sourceforge.net
In-Reply-To: <1063044345.1895.10.camel@hades>
References: <1063044345.1895.10.camel@hades>
Content-Type: text/plain
Message-Id: <1063045080.21991.13.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 08 Sep 2003 18:18:01 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

man, 08.09.2003 kl. 18.05 skrev Mika Liljeberg:
> Hi All,
> 
> Just in case anyone is interested, ATI has released version 3.2.5 of
> their FireGL driver for XFree86. The driver supports all their high end
> graphics cards. This is the first version that has DRM support for the
> 2.6 series of kernels.

Well.. Not really :)

chevrolet:/lib/modules/fglrx/build_mod/2.6.x# make
make -C /lib/modules/2.6.0-test4/build
SUBDIRS=/lib/modules/fglrx/build_mod/2.6.x modules
make[1]: Entering directory `/usr/src/linux-2.6.0-test4'
make[2]: `arch/i386/kernel/asm-offsets.s' is up to date.
*** Warning: Overriding SUBDIRS on the command line can cause
***          inconsistencies
  CC [M]  /lib/modules/fglrx/build_mod/2.6.x/agp3.o
  CC [M]  /lib/modules/fglrx/build_mod/2.6.x/nvidia-agp.o
  CC [M]  /lib/modules/fglrx/build_mod/2.6.x/agpgart_be.o
  CC [M]  /lib/modules/fglrx/build_mod/2.6.x/i7505-agp.o
  CC [M]  /lib/modules/fglrx/build_mod/2.6.x/firegl_public.o
/lib/modules/fglrx/build_mod/2.6.x/firegl_public.c: In function
`firegl_stub_open':
/lib/modules/fglrx/build_mod/2.6.x/firegl_public.c:421: error: called
object is not a function
/lib/modules/fglrx/build_mod/2.6.x/firegl_public.c: In function
`__ke_inode_rdev_minor':
/lib/modules/fglrx/build_mod/2.6.x/firegl_public.c:847: warning:
implicit declaration of function `minor'
make[2]: *** [/lib/modules/fglrx/build_mod/2.6.x/firegl_public.o] Error
1
make[1]: *** [/lib/modules/fglrx/build_mod/2.6.x] Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.0-test4'
make: *** [kmod_build] Error 2
chevrolet:/lib/modules/fglrx/build_mod/2.6.x#

Regards,
Stian

