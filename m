Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbUCVWMh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 17:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263721AbUCVWMC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 17:12:02 -0500
Received: from witte.sonytel.be ([80.88.33.193]:3532 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S263717AbUCVWLv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 17:11:51 -0500
Date: Mon, 22 Mar 2004 23:11:48 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Sam Ravnborg <sam@ravnborg.org>
cc: Kai Germaschewski <kai@germaschewski.name>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] out-of-tree builds
In-Reply-To: <20040315180243.GB8456@mars.ravnborg.org>
Message-ID: <Pine.GSO.4.58.0403222310360.25759@waterleaf.sonytel.be>
References: <Pine.GSO.4.58.0403141353470.1231@waterleaf.sonytel.be>
 <20040315180243.GB8456@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Mar 2004, Sam Ravnborg wrote:
> On Sun, Mar 14, 2004 at 01:58:36PM +0100, Geert Uytterhoeven wrote:
> > Although I like the feature to build a kernel in a different directory a lot, I
> > don't like its syntax. I prefer to just have a build directory where I can run
> > `make whatever'.
> >
> > The following patch adds a configure script to the kernel. If you run
> >
> >     /path/to/kernel/source/tree/configure
> >
> > it will create a Makefile in the current directory, after which you can just do
> > `make whatever', just like in the source directory.
> >
> > The configure script contains a simple protection for when run in the source
> > directory, but this may be approved (I'm not a configure script guru).
> >
> > Comments?
>
> I like the general idea.
> I'm in doubt that configure is the best name, because no actual
> configuration takes place.

I know. But I make it that way because that's how people are used to configure
for out-of-tree builds with autoconf.

> But I want to finish the external modules stuff before introducing
> more features. So it will wait until then.

Let's see what other people think ;-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
