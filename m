Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbTLHXkI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 18:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbTLHXkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 18:40:07 -0500
Received: from mail.kroah.org ([65.200.24.183]:8862 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261928AbTLHXkC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 18:40:02 -0500
Date: Mon, 8 Dec 2003 15:37:55 -0800
From: Greg KH <greg@kroah.com>
To: Bob <recbo@nishanet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: udev sysfs docs Re: State of devfs in 2.6?
Message-ID: <20031208233755.GC31370@kroah.com>
References: <200312081536.26022.andrew@walrond.org> <20031208154256.GV19856@holomorphy.com> <3FD4CC7B.8050107@nishanet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FD4CC7B.8050107@nishanet.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 08, 2003 at 02:09:47PM -0500, Bob wrote:
> William Lee Irwin III wrote:
> 
> >On Mon, Dec 08, 2003 at 03:36:26PM +0000, Andrew Walrond wrote:
> > 
> >
> >>Whats the general feeling about devfs now? I remember Christoph and 
> >>others making some nasty remarks about it 6months ago or so, but later 
> >>noted christoph doing some slashing and burning thereof.
> >>Is it 'nice' yet? 
> >>Andrew Walrond
> >>   
> >>
> >
> >I would say it's deprecated at the very least. sysfs and udev are
> >supposed to provide equivalent functionality, albeit by a somewhat
> >different mechanism.
> >
> >
> >-- wli
> >
> Where can we find documentation on sysfs and udev,
> and on transition issues?

Oh come on, google for "udev FAQ".  It's been posted here a number of
times...

> I know devfs hasn't been maintained for a long time but the
> documentation for it comes with kernel source and there it is in
> menuconfig.

udev is a user program, and it's documentation is not in the kernel
tree.  It's within the source of udev, and is quite extensive.

> Every time I hear that udev and sysfs replace devfs I
> wonder where to pick up the thread, where is that doc,
> where is the menuconfig option ;-)

There is neither.  You always get sysfs in 2.6, and udev is a user
program.  No kernel options to enable (well, you do need CONFIG_HOTPLUG
enabled I guess...)

Please read the udev docs and FAQ, it is there for a reason.

greg k-h
