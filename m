Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264242AbRFDM5p>; Mon, 4 Jun 2001 08:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264230AbRFDMkf>; Mon, 4 Jun 2001 08:40:35 -0400
Received: from aeon.tvd.be ([195.162.196.20]:41068 "EHLO aeon.tvd.be")
	by vger.kernel.org with ESMTP id <S264218AbRFDMka>;
	Mon, 4 Jun 2001 08:40:30 -0400
Date: Mon, 4 Jun 2001 14:37:55 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Oleg Drokin <green@linuxhacker.ru>, Alan Cox <laughing@shared-source.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.5-ac7
In-Reply-To: <E156VvF-0004D1-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.05.10106041435280.28624-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Jun 2001, Alan Cox wrote:
> > Probably there are more such embedded architectures with USB controllers,
> > but not PCI bus.
> 
> Currently we don't support any of them.
> 
> > How about ISA USB host controllers?
> 
> They do not exist. 

Well, there exist USB controllers with Intel/Motorola style bus interfaces, to
be used in e.g. set top boxes without a PCI bus. I think you can glue them
quite easily to an ISA bus. Of course this doesn't mean people actually created
USB plug-in cards for ISA, but it's possible.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

