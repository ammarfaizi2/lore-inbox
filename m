Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315734AbSEQLMf>; Fri, 17 May 2002 07:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315634AbSEQLMe>; Fri, 17 May 2002 07:12:34 -0400
Received: from mail.sonytel.be ([193.74.243.200]:53963 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S315595AbSEQLMd>;
	Fri, 17 May 2002 07:12:33 -0400
Date: Fri, 17 May 2002 13:11:45 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Torrey Hoffman <Torrey.Hoffman@myrio.com>
cc: Rolland Dudemaine <rolland.dudemaine@msg-software.com>, mj@ucw.cz,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: RE: boot logo size patch
In-Reply-To: <A015F722AB845E4B8458CBABDFFE63420FE3EF@mail0.myrio.com>
Message-ID: <Pine.GSO.4.21.0205171310530.395-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 May 2002, Torrey Hoffman wrote:
> Rolland Dudemaine wrote:
> > For a *long* time, the boot logo has stayed in the kernel at many 
> > places. Recently, it has been cleaned up to reduce the number of 
> > identical logos. 
> 
> [...]
> 
> If you are interested in cleaning up the boot logo, you may want to
> check out the patch set at www.arnor.net/linuxlogo
> 
> That sequence of six patches begins as you have, moving LOGO_H and 
> LOGO_W into the individual logo files where they belong.
> 
> The second patch introduces a C program "tologo" to the scripts 
> directory.  It converts arbitrary .ppm files to the linux_logo.h 
> format, but is not 100% done (works correctly for 256 color images
> but not the 16 color or black & white ones)

For a program that handles all cases, check out my page:

    http://home.tvd.be/cr26864/Linux/fbdev/logo.html

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

