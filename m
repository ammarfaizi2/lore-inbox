Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261822AbTC0JIA>; Thu, 27 Mar 2003 04:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261824AbTC0JIA>; Thu, 27 Mar 2003 04:08:00 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:18931 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S261822AbTC0JH7>;
	Thu, 27 Mar 2003 04:07:59 -0500
Date: Thu, 27 Mar 2003 10:18:51 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: James Simmons <jsimmons@infradead.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] Much better framebuffer fixes.
In-Reply-To: <Pine.LNX.4.44.0303270017180.25001-100000@phoenix.infradead.org>
Message-ID: <Pine.GSO.4.21.0303271016300.26358-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Mar 2003, James Simmons wrote:
>  drivers/video/logo/logo.c       |   69 +++++------

Are you sure the change from logo type to logo depth in (fb_)find_logo() won't
have any side effects? After this change, you may receive a different type of
logo than you requested.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

