Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263995AbUGRM6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263995AbUGRM6X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 08:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264045AbUGRM6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 08:58:23 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:1278 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263995AbUGRM6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 08:58:21 -0400
Date: Sun, 18 Jul 2004 14:58:14 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Otto Meier <gf435@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.8-rc2
Message-ID: <20040718125814.GY14733@fs.tum.de>
References: <2jcIK-73Q-5@gated-at.bofh.it> <40FA7242.7050306@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40FA7242.7050306@gmx.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 18, 2004 at 02:51:14PM +0200, Otto Meier wrote:

> Compiling Linux 2.6.8-rc2 I get the following error:
> 
>   SPLIT   include/linux/autoconf.h -> include/config/*
> make[1]: >>arch/i386/kernel/asm-offsets.s<< ist bereits aktualisiert.
>   CHK     include/linux/compile.h
>   GZIP    kernel/config_data.gz
>   IKCFG   kernel/config_data.h
>   CC      kernel/configs.o
>   LD      kernel/built-in.o
>   CC      drivers/video/console/fbcon.o
>...
> drivers/video/console/fbcon.c: In function `fbcon_startup':
> drivers/video/console/fbcon.c:733: error: `cursor_timer' undeclared (first 
> use in this function)
> drivers/video/console/fbcon.c:733: error: (Each undeclared identifier is 
> reported only once
> drivers/video/console/fbcon.c:733: error: for each function it appears in.)
>...
> drivers/video/console/fbcon.c:748: warning: unused variable `cap'
>...
> make[3]: *** [drivers/video/console/fbcon.o] Fehler 1
>...
> 
> Any Idea?

Your line numbers do not match in any way with my copy of 2.6.8-rc2.

Do you have any additional patches applied?

If not, please do a compile from a fresh tree.

> Best regards

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

