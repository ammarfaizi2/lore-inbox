Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264271AbRFOIqH>; Fri, 15 Jun 2001 04:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264272AbRFOIpr>; Fri, 15 Jun 2001 04:45:47 -0400
Received: from hood.tvd.be ([195.162.196.21]:44848 "EHLO hood.tvd.be")
	by vger.kernel.org with ESMTP id <S264271AbRFOIpj>;
	Fri, 15 Jun 2001 04:45:39 -0400
Date: Fri, 15 Jun 2001 10:42:48 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "David S. Miller" <davem@redhat.com>
cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Tom Gall <tom_gall@vnet.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Going beyond 256 PCI buses
In-Reply-To: <15145.3254.105970.424506@pizda.ninka.net>
Message-ID: <Pine.LNX.4.05.10106151041590.32503-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jun 2001, David S. Miller wrote:
> Albert D. Cahalan writes:
>  > >>    /proc/bus/PCI/0/0/3/0/config   config space
>  > >
>  > > Which breaks xfree86 instantly.  This fix is unacceptable.
>  > 
>  > Nope. Keep /proc/bus/pci until Linux 3.14 if you like.
>  > The above is /proc/bus/PCI. That's "PCI", not "pci".
>  > We still have /proc/pci after all.
> 
> Oh I see.
> 
> Well, xfree86 and other programs aren't going to look there, so
> something had to be done about the existing /proc/bus/pci/* hierarchy.
> 
> To be honest, xfree86 needs the controller information not for the
> sake of device probing, it needs it to detect resource conflicts.

Well, those resource conflicts shouldn't be there in the first place. They
should be handled by the OS.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

