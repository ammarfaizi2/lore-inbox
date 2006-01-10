Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbWAJRMA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbWAJRMA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 12:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbWAJRMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 12:12:00 -0500
Received: from mail.kroah.org ([69.55.234.183]:8366 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932267AbWAJRL5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 12:11:57 -0500
Date: Tue, 10 Jan 2006 09:11:02 -0800
From: Greg KH <greg@kroah.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Mark Maule <maule@sgi.com>, Greg KH <gregkh@suse.de>,
       Matthew Wilcox <matthew@wil.cx>, linuxppc64-dev@ozlabs.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 0/3] msi abstractions and support for altix
Message-ID: <20060110171102.GA13239@kroah.com>
References: <20051222201651.2019.37913.96422@lnx-maule.americas.sgi.com> <20051222202259.GA4959@suse.de> <20051222202627.GI17552@sgi.com> <20051222203415.GA28240@suse.de> <20051222203824.GJ17552@sgi.com> <20051222205023.GK2361@parisc-linux.org> <20060103032249.GA4957@sgi.com> <20060103060719.GA1845@suse.de> <20060110170032.GC18399@sgi.com> <20060110170339.GA2567@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060110170339.GA2567@infradead.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2006 at 05:03:39PM +0000, Christoph Hellwig wrote:
> > Ok, looks like it's going to be a bit until I have time to work on the
> > vector allocation stuff.
> > 
> > In the mean time, would folks be recepteive to taking this portion of the
> > initial patchset:
> > 
> > [PATCH 1/4] msi archetecture init hook
> > http://lkml.org/lkml/2005/12/21/168
> > 
> > This would at least give us a graceful pci_enable_msi() failure on altix
> > until I find the time to work on the other stuff.
> 
> Personally I think your patchkit should just go in after all the other
> comments have addresses [1].  It's a huge improvement over the mess that's
> there currently.

Yes, please repost your patches with all of the comments addressed and
we can look at it from there...

thanks,

greg k-h
