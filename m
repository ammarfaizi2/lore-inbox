Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261770AbUKUSaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261770AbUKUSaU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 13:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbUKUSaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 13:30:20 -0500
Received: from mail.kroah.org ([69.55.234.183]:7114 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261770AbUKUSaM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 13:30:12 -0500
Date: Sun, 21 Nov 2004 10:29:52 -0800
From: Greg KH <greg@kroah.com>
To: "Gerold J. Wucherpfennig" <gjwucherpfennig@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel thoughts of a Linux user
Message-ID: <20041121182952.GA26874@kroah.com>
References: <200411201131.12987.gjwucherpfennig@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411201131.12987.gjwucherpfennig@gmx.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2004 at 11:31:12AM +0100, Gerold J. Wucherpfennig wrote:
> > On Thu, Nov 18, 2004 at 06:59:27PM +0100, Gerold J. Wucherpfennig wrote:
> > > 
> > > - Make sysfs optional and enable to publish kernel <-> userspace data
> > > especially the kernel's KObject data across the kernel's netlink interface 
> as
> > > it has been summarized on www.kerneltrap.org. This will avoid the
> > > deadlocks sysfs does introduce when some userspace app holds an open file
> > > handle of an sysfs object (KObject) which is to be removed. An importrant 
> side 
> > > effect for embedded systems will be that the RAM overhead introduced by 
> sysfs
> > > will vaporize.
> > 
> > What RAM overhead?  With 2.6.10-rc2 the memory footprint of sysfs has
> > been drasticly shrunk.
> 
> Sorry I my kernel knowledge only consists of kerneltrap.org news :-(
> I didn't knew that.

Please research things before claiming they are a problem.

> > What deadlocks are you referring to?
> 
> I don't know if it are deadlocks, please read last years article from lwn:
> http://lwn.net/Articles/36850/

My word, that's a year and a half old article.  Do you really think that
we would have not fixed this issue by now?  Again, please do a semblance
of research before claiming there are problems in today's kernels.

> > And the netlink interface for hotplug events is already present in the
> > latest kernel.
> 
> I don't know much about netlink. But sysfs --> libsysfs --> hal --> dbus
> seems to be a lot of an overhead. Maybe create an in-kernel queue
> for hardware information requests and publish the hardware information
> with netlink would be a little less overhead??? Just a though...

Again, please do a bit of research.  This is not how HAL or the hotplug
interfaces work today.

Not to be rude, but again, if you had spent a little ammount of time
looing into the claims you were making, you would have found out that
they were false.

greg k-h
