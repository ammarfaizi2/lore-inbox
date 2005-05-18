Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262098AbVERHed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbVERHed (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 03:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262122AbVERHc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 03:32:27 -0400
Received: from mail.kroah.org ([69.55.234.183]:41141 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262116AbVERHcB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 03:32:01 -0400
Date: Wed, 18 May 2005 00:37:56 -0700
From: Greg KH <greg@kroah.com>
To: Yani Ioannou <yani.ioannou@gmail.com>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH 2.6.12-rc4 1/15] (dynamic sysfs callbacks) device attribute callbacks - take 2
Message-ID: <20050518073756.GA12382@kroah.com>
References: <2538186705051703394944e949@mail.gmail.com> <20050518072239.GA11889@kroah.com> <253818670505180028696cc991@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <253818670505180028696cc991@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2005 at 03:28:23AM -0400, Yani Ioannou wrote:
> Hi Greg,
> 
> On 5/18/05, Greg KH <greg@kroah.com> wrote:
> > Ok, I think I got all of these patches applied properly (hint, don't
> > label your intro message as 1/15, it should be 0/14, with 14 different
> > patches, that threw me off for a bit.)  I've also included your i2c
> > driver patch for the adm1026 driver only.  All of these patches are now
> > in my tree and can be found on kernel.org in the place where my
> > patchscripts notified you.  If you could verify them I would appreciate
> > it (I also added a few patches for stuff that was in my tree only, like
> > new i2c drivers and some usb and pci sysfs stuff to make them build
> > properly.)  All of this should show up in the next -mm release too.
> 
> Thanks a lot! Sorry about the incorrect numbering, first time I've
> done an intro. I'll have to send you a patch against the differences
> between 2.6.12-rc4 and 2.6.12-rc4-mm2 so we don't run into a huge
> amount of trouble when they merge...

That would be good.

> A quick glance through everything looks fine, but I'll do a proper
> check tomorrow using your git tree.

I don't have a git tree for stuff that is not ready to be sent to Linus
at that moment.  I'm using quilt to stage stuff and have them be sucked
into the -mm releases.  It's easier that way for me right now.

thanks,

greg k-h
