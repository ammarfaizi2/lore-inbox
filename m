Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265204AbSJRQsD>; Fri, 18 Oct 2002 12:48:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265207AbSJRQsD>; Fri, 18 Oct 2002 12:48:03 -0400
Received: from avocet.mail.pas.earthlink.net ([207.217.120.50]:51888 "EHLO
	avocet.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S265204AbSJRQsC>; Fri, 18 Oct 2002 12:48:02 -0400
Date: Fri, 18 Oct 2002 09:47:34 -0700 (PDT)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: Bob Billson <reb@bhive.dhs.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: 2.5.42 compiler error in video/vga16fb.c
In-Reply-To: <20021013015301.GB1508@ppc.vc.cvut.cz>
Message-ID: <Pine.LNX.4.33.0210180944520.10832-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It looks like that nobody is interested in VGA anymore. Are there
> any objections against patch below? It is for current 2.5.42-bk,
> and it fixes vga16fb compilability, and adds -depth 8 (to get 320x200, or
> 360x480 in planar mode) and -depth 0 (to get fast textmode) to the vga16fb.

I'm working on it.

> If there are no objections, I'll split it up and send to Linus. But as

Wait. I have your work already in the fbdev BK tree. I'm porting it to the
new api. I just need to write up a fillrect and copy area function for vga
planes mode.

> I already said (and already asked), I'm not going to be vga16fb maintainer
> (because of I use matroxfb everywhere), so if there is somebody else
> who has vga16fb fixes, or who wants to maintain vga16fb, please step up...

I guess I can do it. I need to rewrite vgacon in the near future anyways.

