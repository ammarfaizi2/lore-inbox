Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbVBNWgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbVBNWgi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 17:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVBNWgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 17:36:38 -0500
Received: from lyle.provo.novell.com ([137.65.81.174]:47645 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261246AbVBNWgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 17:36:33 -0500
Date: Mon, 14 Feb 2005 14:36:13 -0800
From: Greg KH <gregkh@suse.de>
To: Harald Dunkel <harald.dunkel@t-online.de>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] hotplug-ng 001 release
Message-ID: <20050214223613.GB13110@suse.de>
References: <20050211004033.GA26624@suse.de> <420D1050.3080405@t-online.de> <20050211210114.GA21314@suse.de> <420DBEBE.1060008@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <420DBEBE.1060008@t-online.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 12, 2005 at 09:30:54AM +0100, Harald Dunkel wrote:
> Greg KH wrote:
> >
> >Because we don't have an easy way yet to build against a copy of klibc
> >on a system?  For right now, it's the simplest way to ensure that it
> >works for everyone, once klibc moves into the kernel tree I can remove
> >it from udev and hotplug-ng.
> >
> 
> If it is not possible to use klibc together with a non-Linux
> system (e.g. FreeBSD or Mach), then I would suggest to make
> klibc an optional kernel patch and drop it from udev and
> hotplug.

But it is not possible to use udev or hotplug-ng on a non-Linux system,
right?

As far as "optional kernel patch"?  What do you mean?  People are
working on adding klibc to the main kernel tree, nothing optional about
that.

> >Is it causing problems for you?
> >
> 
> Some months ago I had contributed a patch to add an install
> target to the klibc Makefiles. I just wonder why it has been
> ignored.

Don't know, I'm not in charge of klibc development.  Why not ask on the
klibc mailing list?

thanks,

greg k-h
