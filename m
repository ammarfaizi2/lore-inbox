Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbTHJJvt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 05:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbTHJJvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 05:51:49 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:42418 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261180AbTHJJvs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 05:51:48 -0400
Date: Sun, 10 Aug 2003 11:51:46 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andrey Borzenkov <arvidjaar@mail.ru>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: mouse and keyboard by default if not embedded
In-Reply-To: <200308101334.14171.arvidjaar@mail.ru>
Message-ID: <Pine.GSO.4.21.0308101150300.19901-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Aug 2003, Andrey Borzenkov wrote:
> > Now INPUT_MOUSEDEV_PSAUX is always (on non-embedded machines) forced to 
> true,
> > even on machines without PS/2 keyboard/mouse hardware. Is that OK?
> 
> > So far (compiling, not running 2.6.0-test3) I didn't notice any problems,
> > though
> 
> there are problems. See
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=106047737716122&w=2
> 
> mouse/atkbd depend on serio driver (i8042) so if i8042 is module and they are 
> forced to be builtin the whole story does not work.
> 
> apparently there are people who build them as modules

I don't have CONFIG_SERIO_I8042 enabled at all, since I'm compiling for a m68k
box without i8042. But it does compile/link.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

