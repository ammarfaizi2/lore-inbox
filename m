Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbTKMJgd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 04:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262330AbTKMJgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 04:36:33 -0500
Received: from witte.sonytel.be ([80.88.33.193]:37865 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262139AbTKMJgc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 04:36:32 -0500
Date: Thu, 13 Nov 2003 10:36:21 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Dax Kelson <dax@gurulabs.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: List of SCO files
In-Reply-To: <1068691791.13135.41.camel@gaston>
Message-ID: <Pine.GSO.4.21.0311131034300.1979-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Nov 2003, Benjamin Herrenschmidt wrote:
> Or just include/asm-m68k/spinlock.h :)
> 
> The whole file is just:
> 
> #ifndef __M68K_SPINLOCK_H
> #define __M68K_SPINLOCK_H
>  
> #error "m68k doesn't do SMP yet"
>  
> #endif

Ah, thank you for checking out the m68k-specific files :-)

Although I don't think I wrote that one, I'm quite sure it was written from
scratch, probably by Jes. I can dig it up if we really need to know...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

