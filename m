Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266137AbUJLQ7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266137AbUJLQ7k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 12:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266233AbUJLQ7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 12:59:40 -0400
Received: from mail.kroah.org ([69.55.234.183]:47575 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266137AbUJLQ7e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 12:59:34 -0400
Date: Tue, 12 Oct 2004 09:58:11 -0700
From: Greg KH <greg@kroah.com>
To: Harald Dunkel <harald.dunkel@t-online.de>
Cc: "J.A. Magallon" <jamagallon@able.es>,
       Lista Mdk-Cooker <cooker@linux-mandrake.com>,
       Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: udev: what's up with old /dev ?
Message-ID: <20041012165809.GA11635@kroah.com>
References: <1097446129l.5815l.0l@werewolf.able.es> <20041012001901.GA23831@kroah.com> <416B91C4.7050905@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <416B91C4.7050905@t-online.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2004 at 10:11:48AM +0200, Harald Dunkel wrote:
> Greg KH wrote:
> >On Sun, Oct 10, 2004 at 10:08:49PM +0000, J.A. Magallon wrote:
> >
> >>Hi all...
> >>
> >>I have just remembered that udev mounts /dev as a tmpfs filesystem, _on 
> >>top_
> >>of the old /dev directory.
> >
> >
> >Well, that's the way _your_ distro does it.  Mine has an empty /dev on
> >the root filesystem, and the init scripts create a ramfs on top of /dev
> >at boot time, which udev fills up.
> 
> I don't like this "my distro is better than yours".

I'm not trying to imply this at all.  All I'm saying is this is a distro
specific issue, not a kernel issue, so it isn't a linux-kernel topic.

> Any pointer to some code online?

Look at the gentoo init package, or read the documentation in the udev
tarball for how to do this for Red Hat.  I've successfully done this on
both distros.

thanks,

greg k-h
