Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263053AbUAHBSV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 20:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbUAHBSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 20:18:21 -0500
Received: from mail.kroah.org ([65.200.24.183]:38284 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263053AbUAHBSS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 20:18:18 -0500
Date: Wed, 7 Jan 2004 17:16:37 -0800
From: Greg KH <greg@kroah.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Linus Torvalds <torvalds@osdl.org>, Andrey Borzenkov <arvidjaar@mail.ru>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: removable media revalidation - udev vs. devfs or static /dev
Message-ID: <20040108011637.GB4002@kroah.com>
References: <200401012333.04930.arvidjaar@mail.ru> <20040103055847.GC5306@kroah.com> <Pine.LNX.4.58.0401071036560.12602@home.osdl.org> <20040107185656.GB31827@kroah.com> <Pine.LNX.4.58.0401071123490.12602@home.osdl.org> <20040108004250.GN4176@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040108004250.GN4176@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 08, 2004 at 12:42:50AM +0000, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Wed, Jan 07, 2004 at 11:31:55AM -0800, Linus Torvalds wrote:
>  
> > NOTE! We do have an alternative: if we were to just make block device 
> > nodes support "readdir" and "lookup", you could just do
> > 
> > 	open("/dev/sda/1" ...)
> > 
> > and it magically works right. I've wanted to do this for a long time, but 
> > every time I suggest allowing it, people scream.
> 
> ... and do so for a good reason.
> 
> Guys, could we please put the entire thing on hold for a week or so?
> There's stuff around the block hotplug that would simplify a lot in
> that area and I'd rather see partitioning code (and bdev code in general,
> for that matter) not messed with until we do that right.

Fine with me, the current situation works just fine for my devices right
now :)

greg k-h
