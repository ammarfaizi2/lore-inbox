Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262558AbTJIUyl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 16:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262560AbTJIUyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 16:54:41 -0400
Received: from mail.kroah.org ([65.200.24.183]:38113 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262558AbTJIUyj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 16:54:39 -0400
Date: Thu, 9 Oct 2003 13:54:13 -0700
From: Greg KH <greg@kroah.com>
To: Ian Kent <raven@themaw.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: devfs vs. udev
Message-ID: <20031009205413.GA12222@kroah.com>
Reply-To: linux-kernel@vger.kernel.org
References: <yw1xad8dfcjg.fsf@users.sourceforge.net> <pan.2003.10.07.13.41.23.48967@dungeon.inka.de> <yw1xekxpdtuq.fsf@users.sourceforge.net> <20031007142349.GX1223@rdlg.net> <pan.2003.10.07.16.06.52.842471@dungeon.inka.de> <20031007165404.GB29870@carfax.org.uk> <20031007174928.GB1956@kroah.com> <1065706989.3203.2.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1065706989.3203.2.camel@raven.themaw.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 09, 2003 at 09:43:10PM +0800, Ian Kent wrote:
> On Wed, 2003-10-08 at 01:49, Greg KH wrote:
> > On Tue, Oct 07, 2003 at 05:54:04PM +0100, Hugo Mills wrote:
> > > 
> > >    Surely udev needs the ability to make more than one device node or
> > > symlink when a device is plugged in anyway, so I just see this as an
> > > issue of writing the appropriate default configuration files.
> > 
> > More than one device node per device?  Why would you want that?
> > 
> > And sure, it's just software, it can be made to do that, if someone
> > sends me a patch... :)
> > 
> 
> Will udev remove the limit on the number of anonymous devices?

udev is a userspace program, it doesn't extend the capability of the
kernel in any manner.  If the kernel has such a limit, there's nothing
that udev can do about it.

thanks,

greg k-h
