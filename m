Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262430AbVFIRwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262430AbVFIRwt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 13:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbVFIRws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 13:52:48 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:37768 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S262430AbVFIRwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 13:52:31 -0400
Date: Thu, 9 Jun 2005 10:52:26 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [GIT PATCH] USB bugfixes and a PCI one too for 2.6.12-rc6
Message-ID: <20050609175225.GA10173@suse.de>
References: <20050609164345.GA9538@kroah.com> <Pine.LNX.4.58.0506091045590.2286@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506091045590.2286@ppc970.osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2005 at 10:49:09AM -0700, Linus Torvalds wrote:
> 
> 
> On Thu, 9 Jun 2005, Greg KH wrote:
> > 
> > Please pull from:
> > 	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/
> > 
> >  drivers/block/ub.c                      |   10 -
> >  drivers/pci/hotplug/cpci_hotplug_core.c |    4 
> >  drivers/pci/hotplug/cpci_hotplug_pci.c  |   10 +
> >  drivers/usb/serial/ftdi_sio.c           |  236 ++++++++++++++++++++++++--------
> >  4 files changed, 198 insertions(+), 62 deletions(-)
> 
> Hmm.. I see the three commits you mention, but this doesn't match what I
> get:
> 
> 	 drivers/block/ub.c                      |    4 +
> 	 drivers/pci/hotplug/cpci_hotplug_core.c |    2 +
> 	 drivers/pci/hotplug/cpci_hotplug_pci.c  |    5 +
> 	 drivers/usb/serial/ftdi_sio.c           |  118 ++++++++++++++++++++++++-------
> 	 4 files changed, 99 insertions(+), 30 deletions(-)
> 
> whazzup?

My scripts generated patches that were duplicates due to either something in my
scripts that messed up, or due to some way that the git commands changed from
the last time I checked.  Odds are it's my fault.  So it counted
everything twice.  Let me go generate the patches again...

Ok, here's what I get:

 drivers/block/ub.c                      |    4 -
 drivers/pci/hotplug/cpci_hotplug_core.c |    2 
 drivers/pci/hotplug/cpci_hotplug_pci.c  |    5 +
 drivers/usb/serial/ftdi_sio.c           |  118 ++++++++++++++++++++++++--------
 4 files changed, 99 insertions(+), 30 deletions(-)

So your merge is correct.  Thanks for verifying.

greg k-h
