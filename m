Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261456AbULNJSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbULNJSU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 04:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbULNJSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 04:18:20 -0500
Received: from witte.sonytel.be ([80.88.33.193]:34015 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261456AbULNJSN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 04:18:13 -0500
Date: Tue, 14 Dec 2004 10:10:38 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Adrian Bunk <bunk@stusta.de>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] remove unused include/asm-m68k/adb_mouse.h (fwd)
In-Reply-To: <20041214004653.GP23151@stusta.de>
Message-ID: <Pine.GSO.4.61.0412141007530.6548@waterleaf.sonytel.be>
References: <20041214004653.GP23151@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Dec 2004, Adrian Bunk wrote:
> The trivial patch forwarded below still applies against 2.6.10-rc3-mm1.

Indeed, it's not even used by some `private' driver in the m68k tree.

> Please apply.

Just in case you're waiting for this additional line:

    Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

> ----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----
> 
> Date:	Wed, 8 Dec 2004 02:14:36 +0100
> From: Adrian Bunk <bunk@stusta.de>
> To: linux-kernel@vger.kernel.org
> Subject: [2.6 patch] remove unused include/asm-m68k/adb_mouse.h
> 
> The patch below removes a completely unused header file.
> 
> 
> diffstat output:
>  include/asm-m68k/adb_mouse.h |   23 -----------------------
>  1 files changed, 23 deletions(-)
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.10-rc2-mm4-full/include/asm-m68k/adb_mouse.h	2004-10-18 23:54:55.000000000 +0200
> +++ /dev/null	2004-11-25 03:16:25.000000000 +0100
> @@ -1,23 +0,0 @@
> -#ifndef _ASM_ADB_MOUSE_H
> -#define _ASM_ADB_MOUSE_H
> -
> -/*
> - * linux/include/asm-m68k/adb_mouse.h
> - * header file for Macintosh ADB mouse driver
> - * 27-10-97 Michael Schmitz
> - * copied from:
> - * header file for Atari Mouse driver
> - * by Robert de Vries (robert@and.nl) on 19Jul93
> - */
> -
> -struct mouse_status {
> -	char		buttons;
> -	short		dx;
> -	short		dy;
> -	int		ready;
> -	int		active;
> -	wait_queue_head_t wait;
> -	struct fasync_struct *fasyncptr;
> -};
> -
> -#endif

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
