Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261910AbUBXIgM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 03:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbUBXIgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 03:36:12 -0500
Received: from witte.sonytel.be ([80.88.33.193]:13501 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261910AbUBXIgI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 03:36:08 -0500
Date: Tue, 24 Feb 2004 09:35:35 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Otto Solares <solca@guug.org>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       James Simmons <jsimmons@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] fbdv/fbcon pending problems
In-Reply-To: <20040224023759.GA16499@guug.org>
Message-ID: <Pine.GSO.4.58.0402240935090.3187@waterleaf.sonytel.be>
References: <1077497593.5960.28.camel@gaston> <20040224023759.GA16499@guug.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Feb 2004, Otto Solares wrote:
> On Mon, Feb 23, 2004 at 11:53:14AM +1100, Benjamin Herrenschmidt wrote:
> - bus_id for each fbdev, so from userland became posible to identify
>   to which card we are controlling.  I know it should be exported via
>   sysfs but an ioctl should be really handy as when you program for
>   fbdev anyway you have to use ioctl's, just to get the bus_is will
>   be a pain use sysfs.

But the goal is to replace these ioctl()s by sysfs, too, isn't it?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
