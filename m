Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129455AbQKCPcw>; Fri, 3 Nov 2000 10:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129471AbQKCPcn>; Fri, 3 Nov 2000 10:32:43 -0500
Received: from styx.cs.kuleuven.ac.be ([134.58.40.3]:57805 "EHLO
	styx.cs.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id <S129455AbQKCPci>; Fri, 3 Nov 2000 10:32:38 -0500
Date: Fri, 3 Nov 2000 15:14:20 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: James Simmons <jsimmons@suse.com>
cc: Petr Vandrovec <vandrove@vc.cvut.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        FrameBuffer List <linux-fbdev@vuser.vu.union.edu>,
        Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: [linux-fbdev] [PATCH] fbcon->vgacon->fbcon
In-Reply-To: <Pine.LNX.4.21.0011022340440.14650-100000@euclid.oak.suse.com>
Message-ID: <Pine.LNX.4.10.10011031513310.1627-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2000, James Simmons wrote:
> > Matroxfb does not switch hardware to VGA mode on exit. Try doing
> > 'fbset -depth 0 -a' before quitting from matroxfb.
> 
> I know. I wanted for vgacon to reset the video mode itself. This way ANY
> fbdev driver can go back top vgacon. 

That won't be possible because returning to VGA text mode is chip-specific.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
