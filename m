Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265077AbTAHKRi>; Wed, 8 Jan 2003 05:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265243AbTAHKRi>; Wed, 8 Jan 2003 05:17:38 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:61131 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S265077AbTAHKRh>;
	Wed, 8 Jan 2003 05:17:37 -0500
Date: Wed, 8 Jan 2003 11:24:22 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: James Simmons <jsimmons@infradead.org>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: rotation.
In-Reply-To: <Pine.LNX.4.44.0301072240530.17129-100000@phoenix.infradead.org>
Message-ID: <Pine.GSO.4.21.0301081120540.21171-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jan 2003, James Simmons wrote:
> I'm about to implement rotation which is needed for devices like the ipaq. 
> The question is do we flip the xres and yres values depending on the 
> rotation or do we just alter the data that will be drawn to make the 
> screen appear to rotate. How does hardware rotate view the x and y axis?
> Are they rotated or does just the data get rotated? 

Where are you going to implement the rotation? At the fbcon or fbdev level?

Fbcon has the advantage that it'll work for all frame buffer devices.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

