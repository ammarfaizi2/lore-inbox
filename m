Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266660AbTAIOD7>; Thu, 9 Jan 2003 09:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266693AbTAIOD7>; Thu, 9 Jan 2003 09:03:59 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:9699 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S266660AbTAIOD6>;
	Thu, 9 Jan 2003 09:03:58 -0500
Date: Thu, 9 Jan 2003 15:08:49 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Rolf Eike Beer <eike@bilbo.math.uni-mannheim.de>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.55] make PCI_LEGACY_PROC depend on PCI
In-Reply-To: <200301090958.30536@bilbo.math.uni-mannheim.de>
Message-ID: <Pine.GSO.4.21.0301091508320.25052-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jan 2003, Rolf Eike Beer wrote:
> from my point of view this would make sense. Or did I miss something magic?
> 
> Rolf Eike Beer
> 
> --- linux-2.5.55-caliban/drivers/pci/Kconfig.old        Thu Jan  9 09:55:07 2003
> +++ linux-2.5.55-caliban/drivers/pci/Kconfig    Thu Jan  9 09:55:24 2003
> @@ -3,6 +3,7 @@
>  #
>  config PCI_LEGACY_PROC
>         bool "Legacy /proc/pci interface"
> +       depends on PCI
>         ---help---
>           This feature enables a procfs file -- /proc/pci -- that provides a
>           summary of PCI devices in the system.

Yes, I needed it on m68k as well.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

