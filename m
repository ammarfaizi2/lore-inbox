Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291161AbSBHMxG>; Fri, 8 Feb 2002 07:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291563AbSBHMwz>; Fri, 8 Feb 2002 07:52:55 -0500
Received: from mail.sonytel.be ([193.74.243.200]:36304 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S291161AbSBHMwp>;
	Fri, 8 Feb 2002 07:52:45 -0500
Date: Fri, 8 Feb 2002 13:52:36 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Dave Jones <davej@suse.de>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Linux Serial Development <linux-serial@vger.kernel.org>
Subject: Re: CONFIG_SERIAL_ACPI and early_serial_setup
In-Reply-To: <20020208134311.D32413@suse.de>
Message-ID: <Pine.GSO.4.21.0202081351201.29963-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Feb 2002, Dave Jones wrote:
> On Fri, Feb 08, 2002 at 01:25:07PM +0100, Geert Uytterhoeven wrote:
>  > If CONFIG_SERIAL_ACPI=y, but CONFIG_SERIAL=m, the kernel (2.4.18-pre9) doesn't
>  > link because early_serial_setup() is not found.
>  > 
>  > I think the correct fix is to not allow CONFIG_SERIAL_ACPI, unless
>  > CONFIG_SERIAL=y.
> 
>  Isn't CONFIG_SERIAL_ACPI an ia64 only option ?

It's not protected by a test for ia64, only by a test for CONFIG_ACPI, and its
Configure.help entry didn't tell me anything suspicious, so I enabled it for my
Vaio.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

