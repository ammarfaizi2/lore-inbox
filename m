Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266880AbUJVTQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266880AbUJVTQr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 15:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264113AbUJVTQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 15:16:35 -0400
Received: from witte.sonytel.be ([80.88.33.193]:65008 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S266155AbUJVTOS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 15:14:18 -0400
Date: Fri, 22 Oct 2004 21:13:52 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Tomas Carnecky <tom@dbservice.com>
cc: root@chaos.analogic.com, Oliver Neukum <oliver@neukum.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: my opinion about VGA devices
In-Reply-To: <417672BF.5040708@dbservice.com>
Message-ID: <Pine.GSO.4.61.0410222112590.11567@waterleaf.sonytel.be>
References: <417590F3.1070807@dbservice.com> <200410201318.26430.oliver@neukum.org>
 <41765A8C.2020309@dbservice.com> <Pine.LNX.4.61.0410200851080.10711@chaos.analogic.com>
 <417672BF.5040708@dbservice.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2004, Tomas Carnecky wrote:
> Last time I've tried a LiveCD distro I've seen a nice boot console with
> background picture, high resolution (1024x768) and nice small font. That means
> that the framebuffer driver had to be initialized at that time. I don't have
> framebuffer drivers compiled into my kernel so I don't know at which point
> these are initialized, but it must be at a quite early point in the boot
> process.

I guess that was vesafb (check /proc/fb). In that case the BIOS initialized the
graphics card to 1024x768 just before the Linux kernel was started.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
