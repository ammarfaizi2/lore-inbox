Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287493AbRLaMMk>; Mon, 31 Dec 2001 07:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287492AbRLaMMb>; Mon, 31 Dec 2001 07:12:31 -0500
Received: from mail.sonytel.be ([193.74.243.200]:55478 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S287493AbRLaMMS>;
	Mon, 31 Dec 2001 07:12:18 -0500
Date: Mon, 31 Dec 2001 13:10:34 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Timothy Covell <timothy.covell@ashavan.org>
cc: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [patch] Re: Framebuffer...Why oh Why???
In-Reply-To: <200112302117.fBULHISr011887@svr3.applink.net>
Message-ID: <Pine.GSO.4.21.0112311307330.1086-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Dec 2001, Timothy Covell wrote:
> 	When X11 locks up, I can still kill it and my box lives.  When
> framebuffers crash, their is no recovery save rebooting.  Back in 1995

When your SCSI driver crashes, their is no recovery save rebooting.
When your IDE driver crashes, their is no recovery save rebooting.
When your Ethernet driver crashes, their is no recovery save rebooting.
...

If a frame buffer device crashes, it's a bug in the frame buffer device driver
(unless the kernel got `tainted' by a user space application with root
 privileges that messed with the graphics card without the frame buffer device
 driver being aware of that).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

