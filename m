Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265798AbTBFJO1>; Thu, 6 Feb 2003 04:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265806AbTBFJO0>; Thu, 6 Feb 2003 04:14:26 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:53915 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S265798AbTBFJOZ>;
	Thu, 6 Feb 2003 04:14:25 -0500
Date: Thu, 6 Feb 2003 10:22:45 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Torrey Hoffman <thoffman@arnor.net>
cc: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: New logo code (fwd)
In-Reply-To: <1044472678.1321.388.camel@rohan.arnor.net>
Message-ID: <Pine.GSO.4.21.0302061020450.3301-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 Feb 2003, Torrey Hoffman wrote:
> Other options that might be useful, but less important: 
> - Single logo option for SMP
> - A "no logo" option, while still including framebuffer support

FB_LOGO=n?

This still includes the logo code (not the images), but that can be fixed.

> - Logo positioning (centered horizontally, vertically, both)
> - Background and foreground text color options.  
> 
> A combination of these features would make it possible to do a smaller
> logo (say, 256 x 128) centered on the screen with a matching background
> color that would make it look like a full-screen logo, while not
> bloating the kernel image much.

Just two extra fields in fb_logo.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

