Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261495AbUKLTO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbUKLTO6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 14:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbUKLTO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 14:14:58 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:59056 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261495AbUKLTO4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 14:14:56 -0500
Date: Fri, 12 Nov 2004 10:59:20 -0800
From: Greg KH <greg@kroah.com>
To: Jan Dittmer <jdittmer@ppp0.net>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Hotplug List <pcihpd-discuss@lists.sourceforge.net>
Subject: Re: [patch 1/2] fakephp: introduce pci_bus_add_device
Message-ID: <20041112185920.GB311@kroah.com>
References: <20040924145542.GA17147@kroah.com> <41687EBA.7050506@ppp0.net> <41688985.7030607@ppp0.net> <41693CF9.10905@ppp0.net> <20041030041615.GH1584@kroah.com> <41857C7A.2030007@ppp0.net> <20041101093514.GA25921@infradead.org> <41880F63.9030606@ppp0.net> <20041111234711.GA11044@kroah.com> <41940019.8000304@ppp0.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41940019.8000304@ppp0.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2004 at 01:13:13AM +0100, Jan Dittmer wrote:
> Greg KH wrote:
> > On Tue, Nov 02, 2004 at 11:51:15PM +0100, Jan Dittmer wrote:
> > 
> >>Christoph Hellwig wrote:
> >>
> >>>On Mon, Nov 01, 2004 at 12:59:54AM +0100, Jan Dittmer wrote:
> >>>
> >>>
> >>>>fakephp needs to add newly discovered devices to the global pci list.
> >>>>Therefore seperate out the appropriate chunk from pci_bus_add_devices
> >>>>to pci_bus_add_device to add a single device to sysfs, procfs
> >>>>and the global device list.
> >>>>
> >>>>Signed-off-by: Jan Dittmer <jdittmer@ppp0.net>
> >>
> >>>the brace should go to a line of it's own
> >>
> >>Sorry about that, updated patch follows:
> > 
> > 
> > Ugh, your email client ate all of the tabs and spit them out as spaces
> > for this patch :(
> > 
> > Care to try it again?
> 
> Well, I still don't know how to do this with Thunderbird as
> non attachment. So here it goes as attachment.

I'll live with that :)

Applied, thanks,

greg k-h
