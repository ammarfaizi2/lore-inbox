Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbVJ1XFM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbVJ1XFM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 19:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbVJ1XFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 19:05:12 -0400
Received: from mail.kroah.org ([69.55.234.183]:12711 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750728AbVJ1XFK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 19:05:10 -0400
Date: Fri, 28 Oct 2005 16:04:27 -0700
From: Greg KH <greg@kroah.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Greg KH <gregkh@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [GIT PATCH] PCI patches for 2.6.14
Message-ID: <20051028230426.GA22073@kroah.com>
References: <20051028225055.GA21464@kroah.com> <20051028225335.GB21871@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051028225335.GB21871@parisc-linux.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2005 at 04:53:35PM -0600, Matthew Wilcox wrote:
> On Fri, Oct 28, 2005 at 03:50:55PM -0700, Greg KH wrote:
> > Here are some PCI patches against your latest git tree.  They have all
> > been in the -mm tree for a while with no problems.
> > 
> > Main things here are:
> > 	- pci-ids.h cleanup
> > 	- shpchp driver cleanup (very good job done here.)
> > 	- more quirks added.
> 
> Does this just about clear you out of pending PCI patches?  I want to do
> the s/hotplug_slot/pci_slot/ changes soon and it'll cause massive
> conflicts with anyone else's pending work.

Yes, it clears out all PCI patches I have, with the exception of the
.owner patch that was sent yesterday to me.

I do have some other pci_find_device patches in my TODO queue that I
need to look at, but I haven't gotten to them yet.

I don't know of any other pending hotplug work, so feel free to hack
away :)

thanks,

greg k-h
