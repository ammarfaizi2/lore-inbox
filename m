Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262704AbVAJWGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262704AbVAJWGX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 17:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262514AbVAJV7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 16:59:09 -0500
Received: from witte.sonytel.be ([80.88.33.193]:26002 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262703AbVAJVqL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 16:46:11 -0500
Date: Mon, 10 Jan 2005 22:45:41 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Greg Ungerer <gerg@snapgear.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       uClinux list <uclinux-dev@uclinux.org>
Subject: Re: [PATCH] m68knommu: cache init code for ColdFire CPU's
In-Reply-To: <200501101711.j0AHB8H5005532@hera.kernel.org>
Message-ID: <Pine.GSO.4.61.0501102244070.1908@waterleaf.sonytel.be>
References: <200501101711.j0AHB8H5005532@hera.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jan 2005, Linux Kernel Mailing List wrote:
> ChangeSet 1.2275, 2005/01/10 07:57:44-08:00, gerg@snapgear.com
> 
> 	[PATCH] m68knommu: cache init code for ColdFire CPU's
> 	
> 	Cache initialization code for the ColdFire CPU's. They are not
> 	all identical. This code is used as part of the common head
> 	start code for all ColdFire platforms.
> 	
> 	Signed-off-by: Greg Ungerer <gerg@snapgear.com>
> 	Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> 
> 
> 
>  mcfcache.h |  125 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 125 insertions(+)
> 
> 
> diff -Nru a/include/asm-m68knommu/mcfcache.h b/include/asm-m68knommu/mcfcache.h
> --- /dev/null	Wed Dec 31 16:00:00 196900
> +++ b/include/asm-m68knommu/mcfcache.h	2005-01-10 09:11:23 -08:00

> + *	Everything from a small linstruction only cache, to configurable
                                ^^^^^^^^^^^^
				instruction

> + *	Simple verion 2 core cache. These have instruction cache only,
               ^^^^^^
	       version

> + *	Version 4 cores have a true hardvard style separate instruction
                                    ^^^^^^^^
				    harvard

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
