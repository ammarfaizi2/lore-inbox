Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291625AbSBAJOe>; Fri, 1 Feb 2002 04:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291626AbSBAJOZ>; Fri, 1 Feb 2002 04:14:25 -0500
Received: from mail.sonytel.be ([193.74.243.200]:45477 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S291627AbSBAJNs>;
	Fri, 1 Feb 2002 04:13:48 -0500
Date: Fri, 1 Feb 2002 10:13:04 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: James Simmons <jsimmons@transvirtual.com>
cc: Linux/m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] amiga keyboard input II
In-Reply-To: <Pine.LNX.4.10.10201311544430.5906-100000@www.transvirtual.com>
Message-ID: <Pine.GSO.4.21.0202011012200.25104-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2002, James Simmons wrote:
> Here is the second patch with much improvements I got from this list.
> Anyone want to try it out? You need to enable input support and Keyboard
> Interface. Then go down and select Amiga keyboard. This is against the
> Dave Jones tree.

> diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj7/drivers/input/keyboard/amikbd.c linux/drivers/input/keyboard/amikbd.c
> --- linux-2.5.2-dj7/drivers/input/keyboard/amikbd.c	Wed Dec 31 16:00:00 1969
> +++ linux/drivers/input/keyboard/amikbd.c	Thu Jan 31 16:38:27 2002

> +	scancode = scancode >> 1;	/* lowest bit is release bit */
> +	down = scancode & 1;

Still to be reordered

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

