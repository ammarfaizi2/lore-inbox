Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267373AbSLEU3k>; Thu, 5 Dec 2002 15:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267374AbSLEU3k>; Thu, 5 Dec 2002 15:29:40 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:30468 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267373AbSLEU3k>; Thu, 5 Dec 2002 15:29:40 -0500
Date: Thu, 5 Dec 2002 20:37:08 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Sven Luther <luther@dpt-info.u-strasbg.fr>
cc: Antonino Daplas <adaplas@pol.net>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] FBDev: vga16fb port
In-Reply-To: <20021205180314.GA860@iliana>
Message-ID: <Pine.LNX.4.44.0212052035330.31967-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Not really. When X closes /dev/fb then fb_release is called which if the 
> 
> That supposes X is fbdev aware (either using the fbdev driver or the
> UseFBDev option), right ? What if X knows nothing about fbdev, it will
> try restoring stuff as if it was in text mode.

That is what X will try. 

> >     X on VESA fb always foobars my system when I exit X.
> 
> With which driver ? (i am happily running the vesa X driver on top of
> vesafb without problems).

G400 X server 4.0.2 ontop of VESA framebuffer.


