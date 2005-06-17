Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262060AbVFQTB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbVFQTB6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 15:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbVFQTB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 15:01:58 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:5816 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S262060AbVFQTBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 15:01:48 -0400
Date: Fri, 17 Jun 2005 12:01:33 -0700
From: Greg KH <gregkh@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: don't override drv->shutdown unconditionally
Message-ID: <20050617190133.GA22280@suse.de>
References: <20050617183057.GA20966@lst.de> <20050617184914.GA22107@suse.de> <20050617185104.GA21256@lst.de> <20050617185311.GC22107@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050617185311.GC22107@suse.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2005 at 11:53:11AM -0700, Greg KH wrote:
> On Fri, Jun 17, 2005 at 08:51:04PM +0200, Christoph Hellwig wrote:
> > They _do_ want it called.  They set the driver-model level one because
> > there hasn't been a pci-level one until a few years ago.
> 
> So they are setting two callbacks?  Have a pointer to any driver that
> does this?

Ok, I see the drivers that do this now, they should be fixed.  I'll make
up a patch now to do that.

thanks,

greg k-h
