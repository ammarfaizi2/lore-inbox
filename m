Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291746AbSBHTJE>; Fri, 8 Feb 2002 14:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291748AbSBHTIy>; Fri, 8 Feb 2002 14:08:54 -0500
Received: from mail.sonytel.be ([193.74.243.200]:27854 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S291746AbSBHTIg>;
	Fri, 8 Feb 2002 14:08:36 -0500
Date: Fri, 8 Feb 2002 20:07:26 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: James Simmons <jsimmons@transvirtual.com>
cc: Jani Monoses <jani@astechnix.ro>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] Tridentfb and resource management
In-Reply-To: <Pine.LNX.4.10.10202080925580.18628-100000@www.transvirtual.com>
Message-ID: <Pine.GSO.4.21.0202082006310.11072-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Feb 2002, James Simmons wrote:
> > Since Tridentfb uses resource management, its initialization must be done
> > before the initialization of the generic drivers (vesafb and offb).
> 
> I assume you mean the pci_resource_xxx stuff. We really need to move all

I meant request_{,mem_}region() (or request_resource()).

> the drivers to this.

Indeed.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

