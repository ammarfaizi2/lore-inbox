Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314557AbSEYNam>; Sat, 25 May 2002 09:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314571AbSEYNal>; Sat, 25 May 2002 09:30:41 -0400
Received: from mail.sonytel.be ([193.74.243.200]:21643 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S314557AbSEYNal>;
	Sat, 25 May 2002 09:30:41 -0400
Date: Sat, 25 May 2002 15:30:34 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>,
        ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: suspend-to-{RAM,disk} for 2.5.17
In-Reply-To: <20020521222858.GA14737@elf.ucw.cz>
Message-ID: <Pine.GSO.4.21.0205251528420.15278-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 May 2002, Pavel Machek wrote:
> Here's suspend-to-{RAM,disk} combined patch for
> 2.5.17. Suspend-to-disk is pretty stable and was tested in
> 2.4-ac. Suspend-to-RAM is little more experimental, but works for me,
> and is certainly better than disk-eating version currently in kernel.

> +#define	LINUX_REBOOT_CMD_SW_SUSPEND	0xD000FCE2
                                                      ^^^^
Are you sure it's system suspend and not system reset? ;-)
Nice to see the Commodore 64 special numbers live on in Linux...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

