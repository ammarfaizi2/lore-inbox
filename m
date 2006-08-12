Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932559AbWHLQOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932559AbWHLQOX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 12:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932561AbWHLQOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 12:14:23 -0400
Received: from mail.suse.de ([195.135.220.2]:19888 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932559AbWHLQOX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 12:14:23 -0400
Date: Sat, 12 Aug 2006 09:14:14 -0700
From: Greg KH <greg@kroah.com>
To: Louis Garcia II <louisg00@bellsouth.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Status of driver core struct device changes?
Message-ID: <20060812161414.GA14182@kroah.com>
References: <1155332969.2652.8.camel@soncomputer> <20060812005959.GA25689@kroah.com> <1155357283.19292.3.camel@soncomputer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155357283.19292.3.camel@soncomputer>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2006 at 12:34:43AM -0400, Louis Garcia II wrote:
> On Fri, 2006-08-11 at 17:59 -0700, Greg KH wrote:
> > On Fri, Aug 11, 2006 at 05:49:29PM -0400, Louis Garcia II wrote:
> > > A couple of months ago greg kh started work toward allowing everything
> > > to be a struct device in the sysfs device tree. How is this progressing?
> > 
> > Quite well.  But next time you might want to CC: me as I almost missed
> > this message.
> > 
> > > Any time frame when we will have a simplified driver core api?
> > 
> > It's getting there.  If you look in -mm there are a lot of subsystems
> > already converted over, along with a lot of patches from andrew that
> > revert these changes due to udev issues.
> > 
> > I'm working on fixing up the udev issues so that the kernel work is not
> > held up.  That's a bit slower going as it requires me to install a lot
> > of different distros...
> > 
> > thanks,
> > 
> > greg k-h
> 
> How about block devices? Will it be moved to /sys/class or is that abi
> set in stone?

Yes, those will also move, but that's a bit lower on my list of things
to do.  Patches to help this out are always welcome.

thanks,

greg k-h
