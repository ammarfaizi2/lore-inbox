Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263667AbTLXQpw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 11:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263679AbTLXQpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 11:45:52 -0500
Received: from mail.kroah.org ([65.200.24.183]:1413 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263667AbTLXQpu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 11:45:50 -0500
Date: Wed, 24 Dec 2003 08:45:15 -0800
From: Greg KH <greg@kroah.com>
To: Kronos <kronos@kronoz.cjb.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysfs class patches - take 2 [0/5]
Message-ID: <20031224164514.GB29365@kroah.com>
References: <20031223220707.GC15946@kroah.com> <20031224142717.GA3133@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031224142717.GA3133@dreamland.darkstar.lan>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 24, 2003 at 03:27:17PM +0100, Kronos wrote:
> Greg KH <greg@kroah.com> ha scritto:
> > > On Tue, Dec 23, 2003 at 04:57:56PM -0500, Jeff Garzik wrote:
> > > Interesting...  I bet that will be useful to the iPAQ folks (I've been 
> > > wading through their patches lately), as they have created a couple 
> > > ultra-simple classes for SoC devices and such.
> >
> > I bet it will.  I've ported my old frame buffer patch to use it, and
> > it saved a lot of code.
> > 
> > Hm, I wonder if the frame buffer people ever intregrated that patch...
> 
> I had a patch that add class_device to struct fb_info. This was 3-4
> months ago.

So all of the frame buffer drivers have to be changed to dynamically
allocate the fb_info structure?  That's the "proper" way to do this, but
I felt it was a bit too late in the 2.6 development cycle to try to
intregrate such a large change in...

Oh well,

greg k-h
