Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270498AbTGSFsU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 01:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270504AbTGSFsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 01:48:20 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:30602 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S270498AbTGSFsQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 01:48:16 -0400
Date: Sat, 19 Jul 2003 08:02:41 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: James Simmons <jsimmons@infradead.org>, Amit Shah <shahamit@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test1: Framebuffer problem
In-Reply-To: <1058562955.19511.65.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.GSO.4.21.0307190801260.26815-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Jul 2003, Alan Cox wrote:
> On Gwe, 2003-07-18 at 21:18, Geert Uytterhoeven wrote:
> > > Then it still needs to be fixed. This works correctly in 2.4
> > Since vesafb can detect whether you booted with a graphics mode, vga16fb should
> > be able to detect you didn't, right?
> 
> Equally it knows that the frame buffer in question was allocated providing
> someone is doing the resource handling right

No, that's not so simple, because vesafb requests the linear frame buffer,
while vga16fb requests the VGA region.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

