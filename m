Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267144AbSLKNi2>; Wed, 11 Dec 2002 08:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267150AbSLKNhj>; Wed, 11 Dec 2002 08:37:39 -0500
Received: from avocet.mail.pas.earthlink.net ([207.217.120.50]:17060 "EHLO
	avocet.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S267144AbSLKNgn>; Wed, 11 Dec 2002 08:36:43 -0500
Date: Wed, 11 Dec 2002 06:36:25 -0800 (PST)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <adaplas@pol.net>
Subject: Re: [TRIVIAL PATCH] FBDEV: Small impact patch for fbdev
In-Reply-To: <A042D564F44@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.33.0212110636000.2617-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > int fb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info)
> > {
> >         int xoffset = var->xoffset;
> >         int yoffset = var->yoffset;
> >         int err;
> >
> >         if (xoffset < 0 || yoffset < 0 || info->fbops->fb_pan_display ||
>
> I'm probably missing something important, but do not you want
>                                            !info->fbops->fb_pan_display
> instead?

Oops. Typo to the screen. That wasn't commited :-)


