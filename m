Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267285AbUIJIBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267285AbUIJIBR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 04:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267199AbUIJIA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 04:00:56 -0400
Received: from witte.sonytel.be ([80.88.33.193]:3775 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S266341AbUIJIAp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 04:00:45 -0400
Date: Fri, 10 Sep 2004 09:57:08 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [PATCH 5/7] fbcon: Fix setup boot options
 of fbcon
In-Reply-To: <200409100534.49269.adaplas@hotpop.com>
Message-ID: <Pine.GSO.4.58.0409100955500.93@waterleaf.sonytel.be>
References: <200409100534.49269.adaplas@hotpop.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Sep 2004, Antonino A. Daplas wrote:
> In the unlikely case of > 10 framebuffers, one can use the characters after
> '9', namely:
>
> ':' = 10
> ';' = 11
> '<' = 12
> '=' = 13
> '>' = 14
> '?' = 15
> '@' = 16
> 'A' = 17
> 'B' = 18
> 'C' = 19
> (and so on until 31, which is the maximum framebuffers allowed)

To avoid problems with the special characters, what about using 0-9 and a-v
instead?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
