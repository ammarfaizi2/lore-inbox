Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286145AbRLaBvg>; Sun, 30 Dec 2001 20:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286147AbRLaBv0>; Sun, 30 Dec 2001 20:51:26 -0500
Received: from www.transvirtual.com ([206.14.214.140]:33298 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S286145AbRLaBvV>; Sun, 30 Dec 2001 20:51:21 -0500
Date: Sun, 30 Dec 2001 17:51:05 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Timothy Covell <timothy.covell@ashavan.org>
cc: Andrew Morton <akpm@zip.com.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Re: Framebuffer...Why oh Why???
In-Reply-To: <200112302231.fBUMVTSr012088@svr3.applink.net>
Message-ID: <Pine.LNX.4.10.10112301748180.20136-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 	Well, I was making reference to Solaris where I have seen
> lots of X11 crashes mean framebuffer crashes which means the console
> is unusable.   I haven't played with it on Linux enough to know for sure that 
> Linux doesn't suffer the same problems.  If that's true, then hats off to you
> all for again showing how Solaris sucks.

Usually the problem with X11 and framebuffer is people forget they need to
use the UseFBDev option for XFree86. You need to tell the X server please
use the fbdev layer to restore the video mode. Otherwise X will try to
reset the card back to the VGA state. 

