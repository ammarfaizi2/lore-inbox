Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932597AbVKBLkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932597AbVKBLkr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 06:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932656AbVKBLkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 06:40:47 -0500
Received: from witte.sonytel.be ([80.88.33.193]:12469 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S932597AbVKBLkr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 06:40:47 -0500
Date: Wed, 2 Nov 2005 12:40:39 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: root <root@lina.inka.de>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: best way to handle LEDs
In-Reply-To: <E1EX7sn-0006It-00@calista.inka.de>
Message-ID: <Pine.LNX.4.62.0511021240120.12392@numbat.sonytel.be>
References: <E1EX7sn-0006It-00@calista.inka.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Nov 2005, root wrote:
> In article <20051101234459.GA443@elf.ucw.cz> you wrote:
> > +static ssize_t leds_store_frequency(struct class_device *dev, const char *buf, size_t size)
> 
> how about using a on and a off timer, so you can set up 50,50 or 10,90 or
> stuff like that to make different pulse.

Or the heartbeat that goes faster if load average increases, as is already
implemented on some archs?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
