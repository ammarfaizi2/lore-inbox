Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261942AbUKUKCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbUKUKCo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 05:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbUKUKCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 05:02:09 -0500
Received: from witte.sonytel.be ([80.88.33.193]:33008 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261288AbUKUKBe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 05:01:34 -0500
Date: Sun, 21 Nov 2004 11:01:22 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andrew Morton <akpm@osdl.org>
cc: Christoph Hellwig <hch@infradead.org>, Linus Torvalds <torvalds@osdl.org>,
       Kars de Jong <jongk@linux-m68k.org>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org
Subject: Re: [PATCH 475] HP300 LANCE
In-Reply-To: <20041116231248.5f61e489.akpm@osdl.org>
Message-ID: <Pine.GSO.4.61.0411211059500.19680@waterleaf.sonytel.be>
References: <200410311003.i9VA3UMN009557@anakin.of.borg>
 <20041101142245.GA28253@infradead.org> <20041116084341.GA24484@infradead.org>
 <20041116231248.5f61e489.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2004, Andrew Morton wrote:
> Christoph Hellwig <hch@infradead.org> wrote:
> > > There's tons of leaks in the hplcance probing code, and it doesn't release
> >  > he memory region on removal either.
> >  > 
> >  > Untested patch to fix those issues below:
> > 
> >  ping.
> 
> The fix needs a fix:

Indeed.

And you should remove the definitions of dio_resource_{start,len}(), as they're
already defined in linux/dio.h.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
