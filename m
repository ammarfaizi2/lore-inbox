Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263963AbUEHAZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263963AbUEHAZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 20:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263943AbUEHAX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 20:23:29 -0400
Received: from mail.kroah.org ([65.200.24.183]:54403 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263939AbUEHAV5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 20:21:57 -0400
Date: Fri, 7 May 2004 16:24:36 -0700
From: Greg KH <greg@kroah.com>
To: Duncan Sands <baldrick@free.fr>
Cc: Grzegorz Kulewski <kangur@polcom.net>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, linux-usb-devel@lists.sourceforge.net,
       speedtouch@ml.free.fr
Subject: Re: [linux-usb-devel] 3 USB regressions (2.6.6-rc3-bk1) that should be fixed before 2.6.6
Message-ID: <20040507232436.GN14660@kroah.com>
References: <Pine.LNX.4.58.0404300113120.444@alpha.polcom.net> <200404301810.56271.baldrick@free.fr> <20040430224111.GB14643@kroah.com> <200405022253.03011.baldrick@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405022253.03011.baldrick@free.fr>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 02, 2004 at 10:53:03PM +0200, Duncan Sands wrote:
> > > Hi Greg, I'm not sure when these problems started showing up, maybe they
> > > have been in 2.6.6- for a while.  One patch that may be worth having in
> > > 2.6.6 by the way is the one for device_disconnect in devio.c that changes
> > > destroy_all_async to destroy_async_on_interface.  It's clearly correct
> > > and does do some good!
> >
> > Care to point out which one this was?  I'm swimming in a sea of patches
> > right now :)
> 
> I rediffed it against Linus's current tree.  The extern -> static change is to make sure
> we avoid the problem reported by R. J. Wysocki for -rc3-mm1: unknown symbol
> destroy_all_async.

Hm, at this point in time, I'll just wait on this.  2.6.6 should be out
shortly I hope...

thanks,

greg k-h
