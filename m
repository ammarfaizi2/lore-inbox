Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263971AbTDWHBJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 03:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263972AbTDWHBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 03:01:09 -0400
Received: from port5.ds1-sby.adsl.cybercity.dk ([212.242.169.198]:54118 "EHLO
	trider-g7.fabbione.net") by vger.kernel.org with ESMTP
	id S263971AbTDWHBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 03:01:07 -0400
Date: Wed, 23 Apr 2003 09:13:11 +0200 (CEST)
From: Fabio Massimo Di Nitto <fabbione@fabbione.net>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [SPARC64] 2.5.68-bk3: problems compiling Creator 3D fb and drm
 (more info)
In-Reply-To: <Pine.LNX.4.53.0304230620020.12279@trider-g7.ext.fabbione.net>
Message-ID: <Pine.LNX.4.53.0304230911570.17139@trider-g7.ext.fabbione.net>
References: <Pine.LNX.4.53.0304230620020.12279@trider-g7.ext.fabbione.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Even trying to comment out one or the other part of the code the kernel
hangs after remapping/booting before initializing the console fb.

Thanks
Fabio

On Wed, 23 Apr 2003, Fabio Massimo Di Nitto wrote:

>
> Hi all,
> 	as in the Subject:
>
> drivers/char/drm/drm_drv.h: In function `drm_init':
> drivers/char/drm/drm_drv.h:550: warning: unused variable `retcode'
> drivers/char/drm/ffb_drv.c: At top level:
> drivers/char/drm/ffb_drv.c:386: redefinition of `ffb_options'
> drivers/char/drm/drm_drv.h:138: `ffb_options' previously defined here
> {standard input}: Assembler messages:
> {standard input}:3018: Error: symbol `ffb_options' is already defined
> make[3]: *** [drivers/char/drm/ffb_drv.o] Error 1
> make[2]: *** [drivers/char/drm] Error 2
> make[1]: *** [drivers/char] Error 2
> make: *** [drivers] Error 2
>
> Both fbdev and drm are compiled in.
>
> Thanks
> Fabio
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
Our mission: make IPv6 the default IP protocol
"We are on a mission from God" - Elwood Blues

http://www.itojun.org/paper/itojun-nanog-200210-ipv6isp/mgp00004.html
