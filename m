Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264045AbUGRNta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264045AbUGRNta (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 09:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264054AbUGRNta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 09:49:30 -0400
Received: from out014pub.verizon.net ([206.46.170.46]:29108 "EHLO
	out014.verizon.net") by vger.kernel.org with ESMTP id S264045AbUGRNt1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 09:49:27 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Organization: Organization: undetectable
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.8-rc2
Date: Sun, 18 Jul 2004 09:49:25 -0400
User-Agent: KMail/1.6
References: <2jcIK-73Q-5@gated-at.bofh.it> <40FA7242.7050306@gmx.net>
In-Reply-To: <40FA7242.7050306@gmx.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407180949.25567.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out014.verizon.net from [151.205.58.143] at Sun, 18 Jul 2004 08:49:26 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 18 July 2004 08:51, Otto Meier wrote:
>Compiling Linux 2.6.8-rc2 I get the following error:
>
>   SPLIT   include/linux/autoconf.h -> include/config/*
>make[1]: >>arch/i386/kernel/asm-offsets.s<< ist bereits
> aktualisiert. CHK     include/linux/compile.h
>   GZIP    kernel/config_data.gz
>   IKCFG   kernel/config_data.h
>   CC      kernel/configs.o
>   LD      kernel/built-in.o
>   CC      drivers/video/console/fbcon.o
>drivers/video/console/fbcon.c: In function `accel_putcs':
>drivers/video/console/fbcon.c:489: warning: unused variable `dst0'
>drivers/video/console/fbcon.c:472: warning: `move_unaligned' might
> be used uninitialized in this function
> drivers/video/console/fbcon.c:475: warning: `move_aligned' might be
> used uninitialized in this function drivers/video/console/fbcon.c:
> In function `fbcon_startup': drivers/video/console/fbcon.c:733:
> error: `cursor_timer' undeclared (first use in this function)
> drivers/video/console/fbcon.c:733: error: (Each undeclared
> identifier is reported only once drivers/video/console/fbcon.c:733:
> error: for each function it appears in.)
> drivers/video/console/fbcon.c: In function `fbcon_init':
>drivers/video/console/fbcon.c:795: error: `SCROLL_YNOMOVE'
> undeclared (first use in this function)
> drivers/video/console/fbcon.c:797: error: `SCROLL_YREDRAW'
> undeclared (first use in this function)
> drivers/video/console/fbcon.c:748: warning: unused variable `cap'
> drivers/video/console/fbcon.c: In function `fbcon_scroll':
>drivers/video/console/fbcon.c:1601: error: `__SCROLL_YMASK'
> undeclared (first use in this function)
> drivers/video/console/fbcon.c:1602: error: `__SCROLL_YMOVE'
> undeclared (first use in this function)
> drivers/video/console/fbcon.c:1609: error: `__SCROLL_YWRAP'
> undeclared (first use in this function) make[3]: ***
> [drivers/video/console/fbcon.o] Fehler 1
>make[2]: *** [drivers/video/console] Fehler 2
>make[1]: *** [drivers/video] Fehler 2
>make: *** [drivers] Fehler 2
>
>
>Any Idea?
>
I've had similar problems several times when I started with the .bz2 
archives, and often a nukeing and re-unpacking fixed it.  I've not 
had any such problems since I began dl'ing only the .gz files.  
Methinks bzip2 still has the potential to get the hiccups from time 
to time on certain data sequences.

>Best regards
>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
There are 4 boxes to be used in defense of liberty. 
Soap, ballot, jury, and ammo.
Please use in that order, starting now.  -Ed Howdershelt, Author
Additions to this message made by Gene Heskett are Copyright 2004, 
Maurice E. Heskett, all rights reserved.
