Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966979AbWK2KbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966979AbWK2KbH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 05:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966975AbWK2KbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 05:31:07 -0500
Received: from vervifontaine.sonytel.be ([80.88.33.193]:62186 "EHLO
	vervifontaine.sonycom.com") by vger.kernel.org with ESMTP
	id S966972AbWK2KbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 05:31:04 -0500
Date: Wed, 29 Nov 2006 11:30:58 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Adrian Bunk <bunk@stusta.de>
cc: Andrew Morton <akpm@osdl.org>,
       Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
       adaplas@pol.net, James Simmons <jsimmons@infradead.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Roman Zippel <zippel@linux-m68k.org>, linux-m68k@vger.kernel.org,
       Linux/PPC Development <linuxppc-dev@ozlabs.org>,
       Sam Creasey <sammy@sammy.net>, sun3-list@redhat.com
Subject: Re: [2.6 patch] remove broken video drivers (v3)
In-Reply-To: <20061129100431.GN11084@stusta.de>
Message-ID: <Pine.LNX.4.62.0611291130070.6335@pademelon.sonytel.be>
References: <20061129100431.GN11084@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2006, Adrian Bunk wrote:
> This patch removes some video drivers that:
> - had already been marked as BROKEN in 2.6.0 three years ago and
> - are still marked as BROKEN.
> 
> These are the following drivers:
> - FB_CYBER
> - FB_VIRGE
> - FB_RETINAZ3
> - FB_SUN3
> 
> Drivers that had been marked as BROKEN for such a long time seem to be
> unlikely to be revived in the forseeable future.
> 
> But if anyone wants to ever revive any of these drivers, the code is
> still present in the older kernel releases.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Acked-By: Geert Uytterhoeven <geert@linux-m68k.org>

> This patch obsoletes the following patches in -mm:
> ioremap-balanced-with-iounmap-for-drivers-video-cyberfb.patch
> ioremap-balanced-with-iounmap-for-drivers-video-retz3fb.patch
> ioremap-balanced-with-iounmap-for-drivers-video-virgefb.patch

If possible, can these still be integrated first, to ease a future
resurrection?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
