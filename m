Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276350AbRJURHs>; Sun, 21 Oct 2001 13:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276359AbRJURHj>; Sun, 21 Oct 2001 13:07:39 -0400
Received: from www.transvirtual.com ([206.14.214.140]:52228 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S276350AbRJURHY>; Sun, 21 Oct 2001 13:07:24 -0400
Date: Sun, 21 Oct 2001 10:06:52 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Jonathan Morton <chromi@cyberspace.org>
cc: lgb@lgb.hu, linux-kernel@vger.kernel.org
Subject: Re: The new X-Kernel !
In-Reply-To: <a05100316b7f84103696e@[192.168.239.101]>
Message-ID: <Pine.LNX.4.10.10110210959110.13079-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Come to think of it, the kernel already supports a fair amount of 
> video hardware, through framebuffer.  I don't know how capable that 
> is, though, beyond displaying and scrolling text in various 
> resolutions, and as a place for XFree86 to fall back to.  If fbdev is 
> accelerated, some kind of userspace utility and kernel-space cleanup 
> would potentially allow fully-accelerated (including 3D?) graphics, 
> with much of the hard work in kernel space.  Or is fbdev just a dumb 
> framebuffer and I'm totally off track?

At present fbdev is just a dumb framebuffer. In time I plan to merge both
DRI and fbdev into one common interface. Their is alot of ideas on where
graphics handling should be done. IMO the kernel should only manage the
state of the hardware amoung the various processes. This is defintely
needed for SMP machines where two processes could be using the hardware 
at the same time. Not actually programming the video hardware. That is
userland job.  

