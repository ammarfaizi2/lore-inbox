Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270327AbTHQQNI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 12:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270332AbTHQQNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 12:13:08 -0400
Received: from mail1.ati.com ([209.50.91.165]:25508 "EHLO mail1.ati.com")
	by vger.kernel.org with ESMTP id S270327AbTHQQNF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 12:13:05 -0400
Message-ID: <328A30E823B7D511A0BF00065B042A3B0172D80D@fgl00exh01.fgl.atitech.com>
From: Alexander Stohr <AlexanderS@ati.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Filip Sneppe <filip.sneppe@yucom.be>
Cc: faith@valinux.com, DRI Devel <dri-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Sun, 17 Aug 2003 18:12:49 +0200
Subject: RE: [Dri-devel] Re: 2.4.22-rc2 unresolved symbols in drm/sis.o wh
	en CONFIG_AGP=m
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
X-Mailer: Internet Mail Service (5.5.2653.19)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

why wont the module compilation still pass
when SIS fb configuration flags from the
Linux kernel configuration are missing?

sorry if that requirement is already
mentioned in the readme. i am just wondering.

-Alex.

> -----Original Message-----
> From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
> Sent: Sunday, August 17, 2003 17:48
> To: Filip Sneppe
> Cc: faith@valinux.com; DRI Devel; Linux Kernel Mailing List
> Subject: [Dri-devel] Re: 2.4.22-rc2 unresolved symbols in 
> drm/sis.o when
> CONFIG_AGP=m
> 
> 
> On Sul, 2003-08-17 at 16:39, Filip Sneppe wrote:
> > Hi,
> > 
> > I get this on Debian Sarge at the end of a "make modules_install":
> > 
> > depmod: *** Unresolved symbols in
> > /lib/modules/2.4.22-rc2/kernel/drivers/char/drm/sis.o
> > depmod:         sis_malloc_Ra3329ed5
> > depmod:         sis_free_Rced25333
> 
> SIS DRM requires SIS frame buffer, known problem
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email sponsored by: Free pre-built ASP.NET sites including
> Data Reports, E-commerce, Portals, and Forums are available now.
> Download today and enter to win an XBOX or Visual Studio .NET.
> http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet
_072303_01/01
_______________________________________________
Dri-devel mailing list
Dri-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/dri-devel


