Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262715AbVCDJUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262715AbVCDJUR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 04:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262720AbVCDJUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 04:20:16 -0500
Received: from witte.sonytel.be ([80.88.33.193]:9938 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262715AbVCDJR6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 04:17:58 -0500
Date: Fri, 4 Mar 2005 10:17:17 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
cc: adaplas@pol.net, Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [2.6 patch] make savagefb one module
In-Reply-To: <20050303230750.GT4608@stusta.de>
Message-ID: <Pine.LNX.4.62.0503041017000.22831@numbat.sonytel.be>
References: <20050301024118.GF4021@stusta.de> <200503040350.51163.adaplas@hotpop.com>
 <20050303202039.GH4608@stusta.de> <200503040437.43495.adaplas@hotpop.com>
 <20050303230750.GT4608@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Mar 2005, Adrian Bunk wrote:
> This patch links all selected files under drivers/video/savagefb/ into 
> one module.
> 
> This required a renaming of savagefb.c to savagefb_driver.c .
> 
> As a side effect, the EXPORT_SYMBOL's in this directory are no longer 
> required.
> 
> ---
> 
> Other names than savagefb_driver.c (e.g. savagefb_main.c) are easily 
> possible - I do not claim being good at picking names...

savagefb_core.c?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
