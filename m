Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264848AbSJaK5p>; Thu, 31 Oct 2002 05:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264849AbSJaK5p>; Thu, 31 Oct 2002 05:57:45 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:15841 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S264848AbSJaK5o>;
	Thu, 31 Oct 2002 05:57:44 -0500
Date: Thu, 31 Oct 2002 12:03:09 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Rusty Russell <rusty@rustcorp.com.au>,
       James Simmons <jsimmons@infradead.org>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>,
       Peter Chubb <peter@chubb.wattle.id.au>, tridge@samba.org,
       "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: What's left over. 
In-Reply-To: <20021031030143.401DA2C150@lists.samba.org>
Message-ID: <Pine.GSO.4.21.0210311140310.15053-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2002, Rusty Russell wrote:
> In message <Pine.LNX.4.44.0210301823120.1396-100000@home.transmeta.com> you wri
> te:
> > On Thu, 31 Oct 2002, Rusty Russell wrote:
> > > Fbdev Rewrite
> > 
> > This one is just huge, and I have little personal judgement on it.
> 
> It's been around for a while.  Geert, Russell?

It's huge because it moves a lot of files around:
  1. drivers/char/agp/ -> drivers/video/agp/
  2. drivers/char/drm/ -> drivers/video/drm/
  3. console related files in drivers/video/ -> drivers/video/console/

(1) and (2) should be reverted, but apparently they aren't reverted in the
patch at http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz yet. The patch
also seems to remove some drivers. Haven't checked the bk repo yet.

James, can you please fix that (and the .Config files)?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

