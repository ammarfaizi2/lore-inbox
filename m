Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263761AbTIHXpT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 19:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263765AbTIHXpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 19:45:19 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:7696 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263761AbTIHXpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 19:45:12 -0400
Date: Tue, 9 Sep 2003 00:45:00 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Sam Ravnborg <sam@ravnborg.org>
cc: Adrian Bunk <bunk@fs.tum.de>, "Randy.Dunlap" <rddunlap@osdl.org>,
       "Justin T. Gibbs" <gibbs@scsiguy.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.6: spurious recompiles
In-Reply-To: <20030907053309.GA963@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.44.0309090044400.23354-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > 2. pnmtologo
> > The following happens again once, but not when doing a third "make":
> >   ./scripts/pnmtologo -t mono -n logo_linux_mono -o drivers/video/logo/logo_linux_mono.c drivers/video/logo/logo_linux_mono.pbm
> >   CC      drivers/video/logo/logo_linux_mono.o
> >   ./scripts/pnmtologo -t vga16 -n logo_linux_vga16 -o drivers/video/logo/logo_linux_vga16.c drivers/video/logo/logo_linux_vga16.ppm
> >   CC      drivers/video/logo/logo_linux_vga16.o
> >   ./scripts/pnmtologo -t clut224 -n logo_linux_clut224 -o drivers/video/logo/logo_linux_clut224.c drivers/video/logo/logo_linux_clut224.ppm
> >   CC      drivers/video/logo/logo_linux_clut224.o
> >   LD      drivers/video/logo/built-in.o
> >   LD      drivers/video/built-in.o
> 
> I have sent a patch to James Simmons some time ago. I will try to dig it
> up and  see if it still applies, and fixes the problem.

I have the patch in the fbdev BK tree.


