Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262318AbVBKTYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262318AbVBKTYu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 14:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbVBKTYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 14:24:50 -0500
Received: from lyle.provo.novell.com ([137.65.81.174]:31573 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S262318AbVBKTXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 14:23:32 -0500
Date: Fri, 11 Feb 2005 11:23:23 -0800
From: Greg KH <gregkh@suse.de>
To: andersen@codepoet.org, Christian Borntr?ger <christian@borntraeger.net>,
       Bill Nottingham <notting@redhat.com>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] hotplug-ng 001 release
Message-ID: <20050211192323.GA19787@suse.de>
References: <20050211004033.GA26624@suse.de> <20050211031823.GE29375@nostromo.devel.redhat.com> <1108104417.32129.7.camel@localhost.localdomain> <200502111719.23163.christian@borntraeger.net> <20050211170144.GA16074@suse.de> <20050211190153.GA8110@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050211190153.GA8110@codepoet.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2005 at 12:01:54PM -0700, Erik Andersen wrote:
> On Fri Feb 11, 2005 at 09:01:44AM -0800, Greg KH wrote:
> > It's not only pci, but all types of busses need this kind of "coldplug"
> > functionality.  And yes, I have plans to provide that functionality in
> > this package too.
> > 
> > In fact, if anyone looking to contribute some well defined and easy to
> > test code... :)
> 
> The pcimodules patch to pciutils does this sortof coldplug device
> scanning for pci devices:
> http://www.linuxfromscratch.org/patches/downloads/pciutils/pciutils-2.1.11-pcimodules-1.patch

Yes, but that uses the modules.pcimap files, which we want to get rid of
someday.  It also uses the /proc/pci interface instead of sysfs, so it
probably doesn't handle machines with pci domains very well...

thanks,

greg k-h
