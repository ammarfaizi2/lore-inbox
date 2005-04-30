Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262543AbVD3Hma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262543AbVD3Hma (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 03:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262546AbVD3Hma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 03:42:30 -0400
Received: from witte.sonytel.be ([80.88.33.193]:55443 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262543AbVD3Hm1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 03:42:27 -0400
Date: Sat, 30 Apr 2005 09:42:18 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Christoph Hellwig <hch@infradead.org>
cc: Dave Jones <davej@redhat.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: tighten i2c dependancies
In-Reply-To: <20050430073518.GB22673@infradead.org>
Message-ID: <Pine.LNX.4.62.0504300941100.20788@numbat.sonytel.be>
References: <20050430055745.GB832@redhat.com> <20050430073518.GB22673@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Apr 2005, Christoph Hellwig wrote:
> On Sat, Apr 30, 2005 at 01:57:45AM -0400, Dave Jones wrote:
> >  config I2C_ALI15X3
> >  	tristate "ALI 15x3"
> > -	depends on I2C && PCI && EXPERIMENTAL
> > +	depends on X86 && I2C && PCI && EXPERIMENTAL
> >  	help
> >  	  If you say yes to this option, support will be included for the
> >  	  Acer Labs Inc. (ALI) M1514 and M1543 motherboard I2C interfaces.
> 
> one of the ali bridges is used on sparc64 aswell, not sure which one.

And there's an ALi M1543 on my NEC DDB Vrc-5074 MIPS board.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
