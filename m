Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266040AbTGDQzS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 12:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266071AbTGDQzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 12:55:18 -0400
Received: from granite.he.net ([216.218.226.66]:30731 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S266040AbTGDQzQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 12:55:16 -0400
Date: Fri, 4 Jul 2003 10:05:47 -0700
From: Greg KH <greg@kroah.com>
To: Dan Aloni <da-x@gmx.net>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] PCI and sysfs fixes for 2.5.73
Message-ID: <20030704170547.GA7752@kroah.com>
References: <20030704020634.GA4316@kroah.com> <20030704065217.GA22032@callisto.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030704065217.GA22032@callisto.yi.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 04, 2003 at 09:52:17AM +0300, Dan Aloni wrote:
> On Thu, Jul 03, 2003 at 07:06:34PM -0700, Greg KH wrote:
> > Hi,
> > 
> > Here's some PCI and sysfs fixes that are against the latest 2.5.74 bk
> > tree.  They include Matthew Wilcox's set of pci cleanups, and sysfs
> > fixes for binary files.  That led into my sysfs attribute file change,
> > which required John Stultz's timer build fix.  I've also added the
> > sysfs/kobject/class rename patches based on previously posted patches.
> 
> That's good, but I see that you didn't add the call to class_device_rename()
> in net/core/dev.c, and that's kinda misses the point ;)

No, I did that on purpose, send this to David Miller, he's the network
maintainer.

thanks,

greg k-h
