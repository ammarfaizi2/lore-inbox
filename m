Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261740AbVASPIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261740AbVASPIs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 10:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbVASPIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 10:08:48 -0500
Received: from witte.sonytel.be ([80.88.33.193]:24451 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261740AbVASPIr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 10:08:47 -0500
Date: Wed, 19 Jan 2005 16:08:07 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: David Woodhouse <dwmw2@infradead.org>
cc: Kumar Gala <kumar.gala@freescale.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] raid6: altivec support
In-Reply-To: <1106146083.26551.526.camel@hades.cambridge.redhat.com>
Message-ID: <Pine.GSO.4.61.0501191606260.15516@waterleaf.sonytel.be>
References: <1106120622.10851.42.camel@baythorne.infradead.org>
 <BD84893E-6A28-11D9-AC28-000393DBC2E8@freescale.com>
 <1106146083.26551.526.camel@hades.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jan 2005, David Woodhouse wrote:
> On Wed, 2005-01-19 at 08:45 -0600, Kumar Gala wrote:
> > We did talk about looking at using some work Ben did in ppc64 with OF 
> > in ppc32.  John Masters was looking into this, but I havent heard much
> > from him on it lately.
> > 
> > The firmware interface on the ppc32 embedded side is some what broken 
> > in my mind.
> 
> The binary structure which changes every few weeks and which is shared
> between the bootloader and the kernel? Yeah, "somewhat broken" is one
> way of putting it :)
> 
> The ARM kernel does it a lot better with tag,value pairs.

As does m68k... That's why we never got beyond bootinfo major version 2.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
