Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263687AbUESL0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263687AbUESL0P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 07:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263685AbUESLUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 07:20:42 -0400
Received: from witte.sonytel.be ([80.88.33.193]:9180 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S263711AbUESLOV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 07:14:21 -0400
Date: Wed, 19 May 2004 13:14:01 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andrew Morton <akpm@osdl.org>
cc: David Eger <eger@theboonies.us>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: FB accel capabilities patch
In-Reply-To: <20040519030319.1f0e6eec.akpm@osdl.org>
Message-ID: <Pine.GSO.4.58.0405191311360.23702@waterleaf.sonytel.be>
References: <Pine.LNX.4.58.0405191118170.4760@rosencrantz.theboonies.us>
 <20040519030319.1f0e6eec.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 May 2004, Andrew Morton wrote:
> David Eger <eger@theboonies.us> wrote:
> > A month or two ago I noticed that the framebuffer console driver doesn't
> >  know to do proper framebuffer acceleration in Linux 2.6;
>
> For what fbdev operations will acceleration be used?

Text console acceleration (rectangle copy, rectangle fill, bitmap expansion,
panning, y-wrap). These have been in use since ages, but the current 2.6 fbcon
code doesn't use all of it anymore.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
