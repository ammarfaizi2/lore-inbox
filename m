Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262273AbVBKRBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbVBKRBz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 12:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262274AbVBKRBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 12:01:55 -0500
Received: from lyle.provo.novell.com ([137.65.81.174]:50765 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S262273AbVBKRBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 12:01:53 -0500
Date: Fri, 11 Feb 2005 09:01:44 -0800
From: Greg KH <gregkh@suse.de>
To: Christian Borntr?ger <christian@borntraeger.net>
Cc: Bill Nottingham <notting@redhat.com>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] hotplug-ng 001 release
Message-ID: <20050211170144.GA16074@suse.de>
References: <20050211004033.GA26624@suse.de> <20050211031823.GE29375@nostromo.devel.redhat.com> <1108104417.32129.7.camel@localhost.localdomain> <200502111719.23163.christian@borntraeger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502111719.23163.christian@borntraeger.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2005 at 05:19:22PM +0100, Christian Borntr?ger wrote:
> On Friday 11 February 2005 07:46, Greg KH wrote:
> > And finally, even if you do use udevstart to manager /sbin/hotplug
> > events, you still need a module autoloader program.  This package
> > provides executables for that problem, if you don't want to (or you
> > can't) use the existing linux-hotplug scripts.  udev will never do the
> > module loading logic, so there's no duplication in this case.
> 
> Greg,
> the pci module autoloader is a real agent, which means it depends on having a 
> hotplug event. Are you planning to support a scan for already present 
> devices, like the pci.rc file in current hotplug solutions?

It's not only pci, but all types of busses need this kind of "coldplug"
functionality.  And yes, I have plans to provide that functionality in
this package too.

In fact, if anyone looking to contribute some well defined and easy to
test code... :)

thanks,

greg k-h
