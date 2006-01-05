Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751904AbWAEDcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904AbWAEDcE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 22:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751903AbWAEDcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 22:32:04 -0500
Received: from c-24-22-115-24.hsd1.or.comcast.net ([24.22.115.24]:57763 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1751904AbWAEDcD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 22:32:03 -0500
Date: Wed, 4 Jan 2006 19:31:52 -0800
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Driver Core patches for 2.6.15
Message-ID: <20060105033152.GA23380@suse.de>
References: <20060105004826.GA17328@kroah.com> <Pine.LNX.4.64.0601041724560.3279@g5.osdl.org> <20060105020742.GA18815@suse.de> <Pine.LNX.4.64.0601041836370.3279@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601041836370.3279@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 06:40:33PM -0800, Linus Torvalds wrote:
> 
> 
> On Wed, 4 Jan 2006, Greg KH wrote:
> > > 
> > > I can do the trivial manual fixup, but when I do, I have two copies of 
> > > "usb_match_id()": one in drivers/usb/core/driver.c and one in 
> > > drivers/usb/core/usb.c.
> > > 
> > > I've pushed out my tree, so that you can see for yourself (it seems to 
> > > have mirrored out too).
> > 
> > Yeah, I was wondering how that would merge together, I'll take a look at
> > the tree after dinner and fix up the problem (there should only be one
> > copy of that function.)
> 
> Actually, looking closer, my first trivial merge was wrong (it took the 
> code from both branches), and doing it right seems to get the proper 
> results (with just one usb_match_id() function).
> 
> I'll push out my _proper_ trivial merge fixup, please just verify that the 
> end result looks sane and matches what you have.

The end result looks sane, thanks for fixing it up.

But it looks like you forgot to pull from my "remove devfs" git tree at:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/devfs-2.6.git/

so you still are missing some patches :)

thanks,

greg k-h
