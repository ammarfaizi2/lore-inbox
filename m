Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262884AbSJaUSY>; Thu, 31 Oct 2002 15:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262906AbSJaUSY>; Thu, 31 Oct 2002 15:18:24 -0500
Received: from flamingo.mail.pas.earthlink.net ([207.217.120.232]:18323 "EHLO
	flamingo.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S262884AbSJaUSW>; Thu, 31 Oct 2002 15:18:22 -0500
Date: Thu, 31 Oct 2002 13:17:43 -0800 (PST)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Rusty Russell <rusty@rustcorp.com.au>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>,
       Peter Chubb <peter@chubb.wattle.id.au>, <tridge@samba.org>,
       "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: What's left over. 
In-Reply-To: <Pine.GSO.4.21.0210311140310.15053-100000@vervain.sonytel.be>
Message-ID: <Pine.LNX.4.33.0210311313420.1721-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > On Thu, 31 Oct 2002, Rusty Russell wrote:
> > > > Fbdev Rewrite
> > >
> > > This one is just huge, and I have little personal judgement on it.
> >
> > It's been around for a while.  Geert, Russell?
>
> It's huge because it moves a lot of files around:
>   1. drivers/char/agp/ -> drivers/video/agp/
>   2. drivers/char/drm/ -> drivers/video/drm/
>   3. console related files in drivers/video/ -> drivers/video/console/
>
> (1) and (2) should be reverted, but apparently they aren't reverted in the
> patch at http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz yet. The patch
> also seems to remove some drivers. Haven't checked the bk repo yet.
>
> James, can you please fix that (and the .Config files)?

Done. I have a new version of that patch at the same place. It is against
2.5.45.

http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

Its still pretty big. We can save the moving of the agp code for post
halloween.




