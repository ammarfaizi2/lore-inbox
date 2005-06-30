Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262917AbVF3JXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262917AbVF3JXE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 05:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262918AbVF3JXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 05:23:03 -0400
Received: from witte.sonytel.be ([80.88.33.193]:37552 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262917AbVF3JVY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 05:21:24 -0400
Date: Thu, 30 Jun 2005 11:18:21 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Arnd Bergmann <arnd@arndb.de>
cc: Rodrigo Nascimento <underscore0x5f@gmail.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       kernel-janitors@lists.osdl.org
Subject: Re: A new soldier
In-Reply-To: <200506290225.05793.arnd@arndb.de>
Message-ID: <Pine.LNX.4.62.0506301117140.11104@numbat.sonytel.be>
References: <cbecb304050628072325516b6e@mail.gmail.com> <200506290225.05793.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jun 2005, Arnd Bergmann wrote:
> If you are looking for something bigger with a steep learning curve,
> you could try to do a sample architecture implementation like
> arch/skeleton and include/asm-skeleton, along the lines of the
> original include/asm-generic directory (asm-generic now serves
> as a place to put code that is the same on most archs but is different
> on others).
> 
> Most new architectures that are added keep copying hacks and obsolete
> code from one of the existing trees, so it would be really nice to
> have a clean starting point for those who don't have as much time to
> find the correct solution as a CS student ;-).
> 
> You would surely learn a lot about the architecture specific parts
> of the kernel and do something useful without the danger of breaking
> code that other people depend on, but it's a lot of work.
> Maybe that can also be done by more that one person.

Sounds like an excellent idea to me! I'm eager to try `make ARCH=skeleton'!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
