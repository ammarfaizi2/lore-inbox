Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268817AbTCCVPo>; Mon, 3 Mar 2003 16:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268819AbTCCVPo>; Mon, 3 Mar 2003 16:15:44 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:23762 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S268817AbTCCVPm>;
	Mon, 3 Mar 2003 16:15:42 -0500
Date: Mon, 3 Mar 2003 22:25:32 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: Antonino Daplas <adaplas@pol.net>, James Simmons <jsimmons@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] Re: FBdev updates.
In-Reply-To: <20030303203500.GA2916@vana.vc.cvut.cz>
Message-ID: <Pine.GSO.4.21.0303032222550.12650-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Mar 2003, Petr Vandrovec wrote:
>   My main concern now is 12x22 font... Accelerator setup
> is so costly for each separate painted character that for 8bpp 
> accelerated version is even slower than unaccelerated one :-(
> (and almost twice as slow when compared with 2.4.x).

Have you already tried Antonino's patches to use one imageblit for multiple
characters with (fontwidth % 8) != 0? It should help.

BTW, I still have to try it with amifb.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


