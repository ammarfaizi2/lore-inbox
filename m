Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265298AbUBEP1f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 10:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265332AbUBEP1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 10:27:35 -0500
Received: from mail.kroah.org ([65.200.24.183]:7329 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265298AbUBEP1e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 10:27:34 -0500
Date: Thu, 5 Feb 2004 07:27:19 -0800
From: Greg KH <greg@kroah.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: odain2@mindspring.com, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: proper place for devfs_register_chrdev with pci_module_init
Message-ID: <20040205152719.GA11080@kroah.com>
References: <18852317.1075926209540.JavaMail.root@wamui01.slb.atl.earthlink.net> <Pine.LNX.4.53.0402041616230.3277@chaos> <200402041648.29096.odain2@mindspring.com> <Pine.LNX.4.53.0402041723340.3515@chaos> <20040204233400.GA5274@kroah.com> <Pine.LNX.4.53.0402050739450.5456@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0402050739450.5456@chaos>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 05, 2004 at 07:42:06AM -0500, Richard B. Johnson wrote:
> On Wed, 4 Feb 2004, Greg KH wrote:
> 
> > On Wed, Feb 04, 2004 at 05:29:31PM -0500, Richard B. Johnson wrote:
> > >
> > > I would call pci_find_class() and continue until a NULL is returned
> > > or my vendor and device are returned in the structure.
> >
> > NOOOOO!!!!!
> >
> > Do NOT do this.  Use pci_register_driver() instead.  Using pci_find_*()
> > is just broken and wrong for 99% of all pci drivers.
> 
> WTF? How do you find out if your board in actually in the system?
> You CANNOT load all possible modules, hoping that somebody will
> hot-plug in one of the devices a year from now.

It is interesting how all of the words in your reply seem to make real
sentances, yet those sentances have nothing to do at all with the topic
at hand.

Please stop trolling the newbies, as much fun as it may seem, it's not a
nice thing to do.

greg k-h
