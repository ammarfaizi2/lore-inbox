Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265865AbUBJNbU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 08:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265872AbUBJNbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 08:31:20 -0500
Received: from witte.sonytel.be ([80.88.33.193]:46317 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S265865AbUBJNbS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 08:31:18 -0500
Date: Tue, 10 Feb 2004 14:31:09 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Greg Kroah-Hartman <greg@kroah.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: dmapool (was: Re: Linux 2.6.3-rc2)
In-Reply-To: <Pine.LNX.4.58.0402091914040.2128@home.osdl.org>
Message-ID: <Pine.GSO.4.58.0402101424250.2261@waterleaf.sonytel.be>
References: <Pine.LNX.4.58.0402091914040.2128@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The dmapool code makes dma_{alloc,free}_coherent() a requirement for all
platforms, breaking platforms that don't have it (e.g. m68k, and from a quick
browse sparc and sparc64 probably, too).

May not be that nice for a release candidate in a stable series...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
