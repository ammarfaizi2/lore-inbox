Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262803AbVAFKRp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262803AbVAFKRp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 05:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262804AbVAFKRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 05:17:45 -0500
Received: from unix.ee ([212.7.4.2]:29445 "EHLO unix.ee") by vger.kernel.org
	with ESMTP id S262803AbVAFKRi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 05:17:38 -0500
Date: Thu, 6 Jan 2005 12:17:37 +0200 (EET)
From: Juri Prokofjev <devel@unix.ee>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-mm2
In-Reply-To: <20050106002240.00ac4611.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0501061203550.12136@jazz.unix.ee>
References: <20050106002240.00ac4611.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jan 2005, Andrew Morton wrote:
..
> drm-add-support-for-new-multiple-agp-bridge-agpgart-api.patch
>  drm: add support for new multiple agp bridge agpgart api
..
During compilation some missing files were found.

..
  gcc -Wp,-MD,drivers/char/drm/.gamma_drv.o.d -nostdinc -isystem 
/usr/lib/gcc-lib/i486-linux/3.3.4/include -D__KERNEL__ -Iinclude  -Wall 
-Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common 
-ffreestanding -O2     -fomit-frame-pointer -pipe -msoft-float 
-mpreferred-stack-boundary=2  -march=i686 -Iinclude/asm-i386/mach-default 
-DMODULE -DKBUILD_BASENAME=gamma_drv -DKBUILD_MODNAME=gamma -c -o 
drivers/char/drm/.tmp_gamma_drv.o drivers/char/drm/gamma_drv.c
drivers/char/drm/gamma_drv.c:39:22: drm_auth.h: No such file or directory
drivers/char/drm/gamma_drv.c:40:28: drm_agpsupport.h: No such file or 
directory
drivers/char/drm/gamma_drv.c:41:22: drm_bufs.h: No such file or directory
In file included from drivers/char/drm/gamma_drv.c:42:
drivers/char/drm/gamma_context.h: In function 
`gamma_context_switch_complete':
...
drivers/char/drm/gamma_drv.c:43:21: drm_dma.h: No such file or 
directory
In file included from drivers/char/drm/gamma_drv.c:44:
drivers/char/drm/gamma_old_dma.h: In function `gamma_clear_next_buffer':
..
drivers/char/drm/gamma_drv.c:45:26: drm_drawable.h: No such file or 
directory
drivers/char/drm/gamma_drv.c:46:21: drm_drv.h: No such file or directory
drivers/char/drm/gamma_drv.c:48:22: drm_fops.h: No such file or directory
drivers/char/drm/gamma_drv.c:49:22: drm_init.h: No such file or directory
drivers/char/drm/gamma_drv.c:50:23: drm_ioctl.h: No such file or directory
drivers/char/drm/gamma_drv.c:51:21: drm_irq.h: No such file or directory
...
drivers/char/drm/gamma_drv.c:53:22: drm_lock.h: No such file or directory
...
