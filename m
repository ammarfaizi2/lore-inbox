Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266870AbUGLPWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266870AbUGLPWN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 11:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266871AbUGLPWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 11:22:13 -0400
Received: from witte.sonytel.be ([80.88.33.193]:46507 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S266870AbUGLPWJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 11:22:09 -0400
Date: Mon, 12 Jul 2004 17:20:32 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: colin@colino.net
cc: michael@mihu.de, Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix saa7146 compilation on 2.6.8-rc1
In-Reply-To: <20040712082545.GA416@jack.colino.net>
Message-ID: <Pine.GSO.4.58.0407121718270.17199@waterleaf.sonytel.be>
References: <20040712082545.GA416@jack.colino.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jul 2004 colin@colino.net wrote:
> this patch fixes a compilation error on 2.6.8-rc1. Here's the error:
> drivers/media/common/saa7146_video.c:3: conflicting types for `memory'
> include/asm-m68k/setup.h:365: previous declaration of `memory'
> make[3]: *** [drivers/media/common/saa7146_video.o] Error 1

But there's nothing named plain `memory' in include/asm-m68k/setup.h?!?!?
Actually there never has been...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
