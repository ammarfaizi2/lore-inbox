Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265638AbSJSReW>; Sat, 19 Oct 2002 13:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265639AbSJSReW>; Sat, 19 Oct 2002 13:34:22 -0400
Received: from modemcable166.48-200-24.mtl.mc.videotron.ca ([24.200.48.166]:49111
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S265638AbSJSReU>; Sat, 19 Oct 2002 13:34:20 -0400
Date: Sat, 19 Oct 2002 13:40:19 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: David Brownell <david-b@pacbell.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Zaurus support for usbnet.c
In-Reply-To: <3DB18DE1.3060003@pacbell.net>
Message-ID: <Pine.LNX.4.44.0210191336430.5873-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Oct 2002, David Brownell wrote:

> Zaurus doesn't have a stock www.handhelds.org kernel; there's a
> different usb slave/target device driver, which uses different
> framing for the Ethernet packets.  Pavel's patch teaches "usbnet"
> about one of those protocols.  (The other is MSFT-friendly.)
> 
> It's worth mentioning the Yopy here too:  Zaurus isn't the only
> SA-1110 based Linux PDA, and its distro is evidently closer to
> the iPAQ distros (but you won't need a WinCE-ectomy).  Current
> versions of "usbnet" have support for a recent YOPY version; they
> use different USB vendor and product IDs "out of the box".

Why not using the same (the best which ever it is) driver instead of 
reinventing the wheel for every SA1110-based devides out there?


Nicolas

