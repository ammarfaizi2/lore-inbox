Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264889AbSLLRpx>; Thu, 12 Dec 2002 12:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264901AbSLLRpx>; Thu, 12 Dec 2002 12:45:53 -0500
Received: from swan.mail.pas.earthlink.net ([207.217.120.123]:44947 "EHLO
	swan.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S264889AbSLLRpw>; Thu, 12 Dec 2002 12:45:52 -0500
Date: Thu, 12 Dec 2002 10:45:20 -0800 (PST)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Antonino Daplas <adaplas@pol.net>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [FBDEV]: Framebuffer driver for Intel 810/815 chipsets
In-Reply-To: <1039603490.1147.80.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0212121045060.32196-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Applied !!!!

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@users.sf.net] 	                ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net

On 11 Dec 2002, Antonino Daplas wrote:

> James,
>
> It seems the fbdev framework is stable enough, and already in the
> development tree.  So, I'm submitting a driver for the Intel 810/815 for
> review and perhaps inclusion to your tree (to get more testing), and
> hopefully merge with Linus's tree.
>
> The patch is against linux-2.5.51, but will not work yet because of 2
> reasons:
>
> 1. agpgart is not working for the i810
> 2. support for early agp initialization needs to be added.
>
> Once #1 is fixed, the driver should work as a module.  And once #2 gets
> included, the driver can be compiled statically.  Dave Jones (thanks for
> the help, by the way) has already #2 in his tree (tested and works), and
> is currently working on #1 (I have a hacked version at home).
>
> The driver should be compliant with fbdev-2.5, and should support most
> if not all features that are to be expected (modularity, state saving
> and restoring, full hardware support, etc).  One thing also that's very
> important for many people is that the driver will work with XFree86 with
> its native i810 drivers without further modification, and quite stably
> too.
>
> The patch is at
> http://i810fb.sourceforge.net/linux-2.5.51-i810fb.diff.gz
>
> Thanks,
>
> Tony
>
>
>
>
>

