Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262823AbVFVHwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262823AbVFVHwA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 03:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262876AbVFVHrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 03:47:31 -0400
Received: from nproxy.gmail.com ([64.233.182.201]:1117 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262819AbVFVGXn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 02:23:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Tqlg30EMMZcI+ThPANatPPX/PAvFn6CB3SI/xhzEGpXiuoohH9SGSH+izYK5ysH/suDeZ/c8iIcqO4k7iUJAuMHeeicuisdjjJnIdHuj3nAH4LaZMfTmTbgXlA4Bu0c7NU2BgenRPTBMOhBT8bcDC6mUR6WE5OguPBoKNG0Vij0=
Message-ID: <2cd57c900506212323ca68045@mail.gmail.com>
Date: Wed, 22 Jun 2005 14:23:36 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: coywolf@lovecn.org
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] devfs: remove devfs from Kconfig preventing it from being built
Cc: gregkh@suse.de, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050621.214527.71091057.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050621222419.GA23896@kroah.com>
	 <20050621.155919.85409752.davem@davemloft.net>
	 <20050622041330.GB27716@suse.de>
	 <20050621.214527.71091057.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/05, David S. Miller <davem@davemloft.net> wrote:
> From: Greg KH <gregkh@suse.de>
> Date: Tue, 21 Jun 2005 21:13:30 -0700
> 
> > On Tue, Jun 21, 2005 at 03:59:19PM -0700, David S. Miller wrote:
> > > From: Greg KH <gregkh@suse.de>
> > > Date: Tue, 21 Jun 2005 15:24:19 -0700
> > >
> > > However, this does mean I do need to reinstall a couple
> > > debian boxes here to something newer before I can continue
> > > doing kernel work in 2.6.x on them.
> >
> > Those boxes rely on devfs?
> 
> Yeah, when I forget to turn on DEVFS_FS and DEVFS_MOUNT in the
> kernel config the machine won't boot. :-)
> 
> > Can't you just grab the "static dev" debian package and continue on?
> > I'm sure there is one in there somewhere (don't really know for sure,
> > not running debian anywhere here, sorry.)
> >
> > Or how about a tarball of a /dev tree?  Would that help you out?

There's /sbin/MAKEDEV on debian.

> 
> I don't know if Debian has such a package.
> 
> Don't worry, I'll take care of this by simply reinstalling
> and thus moving to udev.

Moving to udev is right. Still you need a "static dev" in case your
udev not working.

Use /sbin/MAKEDEV from makedev package.

-- 
Coywolf Qi Hunt
http://ahbl.org/~coywolf/
