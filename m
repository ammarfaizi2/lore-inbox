Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262996AbTC0PrI>; Thu, 27 Mar 2003 10:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263025AbTC0PrI>; Thu, 27 Mar 2003 10:47:08 -0500
Received: from ip68-13-105-80.om.om.cox.net ([68.13.105.80]:3968 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S262996AbTC0PrH>; Thu, 27 Mar 2003 10:47:07 -0500
Date: Thu, 27 Mar 2003 09:58:12 -0600 (CST)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@localhost.localdomain
To: Helge Hafting <helgehaf@aitel.hist.no>
cc: James Simmons <jsimmons@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: Much better framebuffer fixes.
In-Reply-To: <3E82CB28.8020001@aitel.hist.no>
Message-ID: <Pine.LNX.4.44.0303270949210.947-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Mar 2003, Helge Hafting wrote:

> James Simmons wrote:
> > Okay. Here are more framebuffer fixes. Please try these fixes and let me 
> > know how they work out for you.
> > 
> 
> The cursor line on radeonfb now is solid, instead of the broken line
> in 2.5.66.  It is still impossible to set the resolution.
> 
> The lilo approach:
> append="video=radeonfb:1280x1024-24@60"
> This seems to do nothing.  I get the same low resolution as
> plain 2.5.66, which looks bad as it don't match the flat screen resolution.

The framebuffer behaviour is back to "normal".  I'm not having the 
resolution problems, but I'm not using the same parameters.  My append 
line simply says vga=792.

Any idea of what will go to Linus and when it might make it into mainline?

