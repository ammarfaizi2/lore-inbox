Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbTI1KXU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 06:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262364AbTI1KXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 06:23:20 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.18]:52822 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S262360AbTI1KXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 06:23:19 -0400
Date: Sun, 28 Sep 2003 12:14:18 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Bernardo Innocenti <bernie@develer.com>
cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test6
Message-ID: <Pine.LNX.4.44.0309281213240.4929-100000@callisto>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 27 Sep 2003, Linus Torvalds wrote:
> Bernardo Innocenti:
>   o GCC 3.3.x/3.4 compatiblity fix in include/linux/init.h

This change breaks 2.95 for some source files, because <linux/init.h> doesn't
include <linux/compiler.h>. Do you want to have the missing include added to
<linux/init.h>, or to the individual source files that need it?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

