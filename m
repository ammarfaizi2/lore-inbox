Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264777AbUDWJ3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264777AbUDWJ3Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 05:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264776AbUDWJ3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 05:29:25 -0400
Received: from witte.sonytel.be ([80.88.33.193]:10724 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S264774AbUDWJ3X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 05:29:23 -0400
Date: Fri, 23 Apr 2004 11:29:20 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Meelis Roos <mroos@linux.ee>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: modular vga16fb on PPC32
In-Reply-To: <Pine.GSO.4.44.0404231147360.15262-100000@math.ut.ee>
Message-ID: <Pine.GSO.4.58.0404231128120.11983@waterleaf.sonytel.be>
References: <Pine.GSO.4.44.0404231147360.15262-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Apr 2004, Meelis Roos wrote:
> This is from current 2.6.6-rc2+BK:
>
> *** Warning: "vgacon_remap_base" [drivers/video/vga16fb.ko] undefined!
>
> Do we need to export vgacon_remap_base?

Yes. It's been a while ago I tried, but vga16fb used to work on the S3 in my
LongTrail after I initialized that card using the video BIOS emulator.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
