Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314584AbSEYNpY>; Sat, 25 May 2002 09:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314600AbSEYNpX>; Sat, 25 May 2002 09:45:23 -0400
Received: from mail.sonytel.be ([193.74.243.200]:37004 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S314584AbSEYNpW>;
	Sat, 25 May 2002 09:45:22 -0400
Date: Sat, 25 May 2002 15:45:11 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: =?ISO-8859-1?Q? Fran=E7ois?= Leblanc <francois.leblanc@cev-sa.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernel 2.4.18 endianness logical mistakes correction on
 fbcon-cfb2.c and fbcon-cfb4.c
In-Reply-To: <004001c20309$2832c4c0$6601a8c0@stlo.cevsa.com>
Message-ID: <Pine.GSO.4.21.0205251543260.15278-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 May 2002, =?ISO-8859-1?Q? Fran=E7ois?= Leblanc wrote:
> DESCRIPTIONS:
> 
> 2 small patchs to apply to:
> 
> drivers\video\fbcon-cfb2.c
> drivers\video\fbcon-cf4.c o
> 
> This patchs correct the endianness logical of nibbletab, the first table is
> u_char mades so no endian needed and the second swap correctly bytes in
> LITTLE_ENDIAN. (old version swap half bytes instead of bytes).

For pixels smaller than a byte, it also depends on what's the order of the
pixels in a byte. So all possibilities are actually possible.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

