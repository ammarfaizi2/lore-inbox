Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267505AbUIKHlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267505AbUIKHlk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 03:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267602AbUIKHlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 03:41:40 -0400
Received: from witte.sonytel.be ([80.88.33.193]:22717 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S267505AbUIKHky (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 03:40:54 -0400
Date: Sat, 11 Sep 2004 09:40:52 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Dave Airlie <airlied@linux.ie>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: radeon-pre-2
In-Reply-To: <Pine.LNX.4.58.0409110009460.13921@skynet>
Message-ID: <Pine.GSO.4.58.0409110939070.17924@waterleaf.sonytel.be>
References: <E3389AF2-0272-11D9-A8D1-000A95F07A7A@fs.ei.tum.de> 
 <Pine.LNX.4.58.0409100209100.32064@skynet> <9e47339104090919015b5b5a4d@mail.gmail.com>
 <20040910153135.4310c13a.felix@trabant> <9e47339104091008115b821912@mail.gmail.com>
 <1094829278.17801.18.camel@localhost.localdomain> <9e4733910409100937126dc0e7@mail.gmail.com>
 <1094832031.17883.1.camel@localhost.localdomain> <9e47339104091010221f03ec06@mail.gmail.com>
 <1094835846.17932.11.camel@localhost.localdomain> <9e47339104091011402e8341d0@mail.gmail.com>
 <Pine.LNX.4.58.0409102254250.13921@skynet> <1094853588.18235.12.camel@localhost.localdomain>
 <Pine.LNX.4.58.0409110009460.13921@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Sep 2004, Dave Airlie wrote:
> Lots of X DDX drivers use the accelerator for 2d stuff, some fbs use it
> for accelerating scrolling, the DRM uses it, this is wrong wrong wrong
> wrong...X/DRM at least lock each other out, but the fb just tramps in
> wearing its size nines.. so in summary the 2D/3D split exists in peoples
> minds (graphics cards designers excepted...)

Who tramps on who actually depends on your point of view... ;-)

First we had fbdev in the kernel (and some X played nice with it), then we also
got DRM...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
