Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278617AbRKHWYk>; Thu, 8 Nov 2001 17:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278662AbRKHWYa>; Thu, 8 Nov 2001 17:24:30 -0500
Received: from cpe-24-221-186-48.ca.sprintbbd.net ([24.221.186.48]:31241 "HELO
	jose.vato.org") by vger.kernel.org with SMTP id <S278617AbRKHWYQ>;
	Thu, 8 Nov 2001 17:24:16 -0500
From: "Tim Pepper" <tpepper@vato.org>
Date: Thu, 8 Nov 2001 14:24:12 -0800
To: linux-kernel@vger.kernel.org
Subject: Big USB speed difference when compiled as module (was Re: speed difference between using hard-linked and modular drives?)
Message-ID: <20011108142412.A19451@vato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 08 Nov at 17:01:24 +0100 roy@karlsbakk.net done said:
> 
> Are there any speed difference between hard-linked device drivers and
> their modular counterparts?

I've been wondering this as well.  I've got a curious situation:  With usbcore
and the uhci driver compiled into the kernel I can initiate transfers to a usb
device I have (Creative Nomad Jukebox) at what I'm eyeballing to be near the
12Mbps USB speed.  These tranfers always fail.  With both drivers compiled as
modules the transfers are over an order of magnitude slower, not even
appearing to reach the 1.5Mbps USB speed, but they succeed.  I haven't had a
chance to try to figure out what's going on for sure.

It's been a little while since I was playing with this but I believe I saw
the same thing with the usb-uhci driver as well but it didn't seem to like
talking to the Nomad regardless of it being compiled as a module or not.
This was with the 2.4.13 kernel.  I can provide more details upon request.

BTW: is there a way to do USB sniffing in software in linux?  I'd imagine it's
possible, but just can't find anything that does...


Tim
