Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262712AbUKEQIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262712AbUKEQIh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 11:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262717AbUKEQIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 11:08:36 -0500
Received: from mx.inch.com ([216.223.198.27]:64274 "EHLO util.inch.com")
	by vger.kernel.org with ESMTP id S262712AbUKEQHA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 11:07:00 -0500
Date: Fri, 5 Nov 2004 11:06:49 -0500 (EST)
From: John McGowan <jmcgowan@inch.com>
To: Dave Airlie <airlied@gmail.com>
cc: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.9: i810 video
In-Reply-To: <21d7e99704110421597deb381c@mail.gmail.com>
Message-ID: <20041105110215.I85742@shell.inch.com>
References: <21d7e99704110314156bb270de@mail.gmail.com> 
 <20041102215308.GA3579@localhost.localdomain>  <20041103234045.G92772@shell.inch.com>
 <418AA075.3070303@tmr.com>  <20041104172521.I42459@shell.inch.com>
 <21d7e99704110421597deb381c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Nov 2004, Dave Airlie wrote:

> >
> > By the way, the X server runs. There is no problem with that.
> >
> > If I start it (say, with ICE as a window manager starting up an xterm)
> > *immediately after boot* I get a clean, black screen. It should be dark
> > green. I get the frame for the xterm. No xterm. I can right click to get
> > the menu to display on the screen but it gets locked there. I can right
> > click again to get a working menu and choose to logout.
> >
> > If I do something befor starting it, the screen is filled with junk.
> > Something is writing to the video ram. If I close it and restar it,
> > different junk.
> >
> > It seems that the initialization of the i810 is leaving its video ram
> > free to be grabbed and used.
>
> Can you throw your .config this way as well, I've just built 2.6.9
> with i810 drm and no i810 framebuffer (CONFIG_DRM_I810 and
> !CONFIG_FB_I810) and played tuxracer just fine for a few minutes under
> a gnome session on a Fedora core 1 box with a prerelease of Xorg
> 6.8... (my i810 test machine doesn't get taken out all that often...)
>
> I did just modprobe the i810 framebuffer module I also built and try
> to start X and X wouldn't start with a unable to bind system texture
> memory,.... so trying building a kernel without i810 framebuffer
> switched on a see what happens..

I had compiled a kernel without frame buffer (no frame buffer support at
all). Starting X gave the same screen (if I start X after doing something,
it come up with junk on it - if I start X immediately after booting, it
comes up black (should be dark green) and is unusable).

Let me try the simplest kernel configuration I can.

Regards from:

    John McGowan  |  jmcgowan@inch.com                [Internet Channel]
                  |  jmcgowan@coin.org                [COIN]
    --------------+-----------------------------------------------------
