Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263712AbTDDM0h (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 07:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263714AbTDDMVB (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 07:21:01 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:9210 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id S263703AbTDDMMM (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 07:12:12 -0500
Date: Fri, 4 Apr 2003 14:22:03 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] interlaced packed pixels
In-Reply-To: <1049454984.2138.2.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.GSO.4.21.0304041418000.1720-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Op vrijdag 4 April 2003, schreef Alan Cox:
> On Gwe, 2003-04-04 at 12:17, Geert Uytterhoeven wrote:
     ^^^                                          ^^^^^
The Welsh setup isn't 100% finished yet ;-)

> > I'd like to introduce a new frame buffer type to accommodate packed pixel frame
> > buffers that store the even and odd fields separately. This is typically used
> > in graphics hardware for TV output (e.g. set-top boxes).
> 
> While we are at it can we also get an FB_TYPE_MJPEG ?

What's the exact format description for MJPEG? YUV 4:*:*?
Shouldn't that be a FB_VISUAL_MJPEG?

Groetjes,

						Geert

--
Geert Uytterhoeven -- Er is heel wat Linux na ia32 -- geert@linux-m68k.org

Tijdens persoonlijke conversaties met technisch-georiënteerde mensen noem ik
mezelf een hacker. Maar als ik met een journalist praat zeg ik gewoon
`programmeur' of iets in die aard.
							    -- Linus Torvalds

