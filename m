Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162346AbWKQFRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162346AbWKQFRT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 00:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162081AbWKQFRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 00:17:19 -0500
Received: from vervifontaine.sonytel.be ([80.88.33.193]:54916 "EHLO
	vervifontaine.sonycom.com") by vger.kernel.org with ESMTP
	id S1162036AbWKQFRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 00:17:18 -0500
Date: Fri, 17 Nov 2006 06:17:11 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg Ungerer <gerg@snapgear.com>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-m68k@vger.kernel.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       uClinux list <uclinux-dev@uclinux.org>
Subject: Re: m68knommu doesn't build upstream
In-Reply-To: <1163739105.5940.431.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0611170615420.16998@pademelon.sonytel.be>
References: <1163739105.5940.431.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2006, Benjamin Herrenschmidt wrote:
> While looking into getting rid of the old compat dma-mapping stuff,
> which is only used by a handful of archs, I've built some cross
> toolchains for those archs in order to at least test build my changes.
> 
> It looks however that one of them, m68knommu, doesn't build with
> upstream git and a defconfig
> 
>  In file included from arch/m68knommu/kernel/asm-offsets.c:18:
> include/asm/irqnode.h:26: error: conflicting types for 'irq_handler_t'
> include/linux/interrupt.h:67: error: previous declaration of 'irq_handler_t' was here
> 
> Is this arch bitrotting ?

Maybe, although Greg announces updated versions on a regular basis.

BTW, m68knommu is not really handled by linux-m68k. Please use uclinux-dev
instead.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
