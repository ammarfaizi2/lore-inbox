Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265757AbTIEU5g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 16:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265800AbTIEU5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 16:57:36 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:34981 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S265757AbTIEU4d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 16:56:33 -0400
Date: Fri, 5 Sep 2003 22:56:30 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Paul Mackerras <paulus@samba.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix ppc ioremap prototype
In-Reply-To: <16215.51281.872936.333230@nanango.paulus.ozlabs.org>
Message-ID: <Pine.GSO.4.21.0309052255390.9568-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Sep 2003, Paul Mackerras wrote:
> Geert Uytterhoeven writes:
> > inb() and friends are for ISA/PCI I/O space
> > isa_readb() and friends are for ISA memory space
> > readb() and friends are for PCI memory space (after ioremap())
> > 
> > That's why other buses (e.g. SBUS and Zorro) have their own versions of
> > ioremap() and readb() etc.).
> 
> I suggest you fix Documentation/zorro.txt then: 8-)
> 
> : 		  Writing Device Drivers for Zorro Devices
> : 		  ----------------------------------------
> : 
> : Written by Geert Uytterhoeven <geert@linux-m68k.org>
> : Last revised: February 27, 2000

Thanks for reminding me I have to update this doc! Expect a patch soon ;-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

