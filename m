Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267389AbSLEUiQ>; Thu, 5 Dec 2002 15:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267390AbSLEUiQ>; Thu, 5 Dec 2002 15:38:16 -0500
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25]:61163 "EHLO
	mel-rto6.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S267389AbSLEUiO>; Thu, 5 Dec 2002 15:38:14 -0500
Date: Thu, 5 Dec 2002 21:44:42 +0100
To: James Simmons <jsimmons@infradead.org>
Cc: Sven Luther <luther@dpt-info.u-strasbg.fr>,
       Antonino Daplas <adaplas@pol.net>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] FBDev: vga16fb port
Message-ID: <20021205204442.GA1103@iliana>
References: <20021205180314.GA860@iliana> <Pine.LNX.4.44.0212052035330.31967-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212052035330.31967-100000@phoenix.infradead.org>
User-Agent: Mutt/1.4i
From: Sven Luther <luther@dpt-info.u-strasbg.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2002 at 08:37:08PM +0000, James Simmons wrote:
> 
> > > Not really. When X closes /dev/fb then fb_release is called which if the 
> > 
> > That supposes X is fbdev aware (either using the fbdev driver or the
> > UseFBDev option), right ? What if X knows nothing about fbdev, it will
> > try restoring stuff as if it was in text mode.
> 
> That is what X will try. 

Mmm, is it enough for X to just save/restore the registers it modifies ?

Also, i suppose if i am comming from fbdev, what X saves or restores
does not really count, since fbdev knows what relevant thing to save.

Still i sense that there may be some issues involved here, especially
if you switch from text mode to fbdev or between fbdevs while not in X.

> > >     X on VESA fb always foobars my system when I exit X.
> > 
> > With which driver ? (i am happily running the vesa X driver on top of
> > vesafb without problems).
> 
> G400 X server 4.0.2 ontop of VESA framebuffer.

And i suppose the VESA driver will work, right ?

Friendly,

Sven Luther
