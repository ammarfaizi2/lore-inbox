Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261807AbULURHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbULURHe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 12:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbULURHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 12:07:32 -0500
Received: from mail.kroah.org ([69.55.234.183]:53904 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261807AbULURH1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 12:07:27 -0500
Date: Tue, 21 Dec 2004 09:05:28 -0800
From: Greg KH <greg@kroah.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       Bjorn Helgaas <bjorn.helgaas@hp.com>, willy@debian.org,
       benh@kernel.crashing.org
Subject: Re: [PATCH] add PCI API to sysfs
Message-ID: <20041221170528.GB1459@kroah.com>
References: <200412201450.47952.jbarnes@engr.sgi.com> <20041220225817.GA21404@kroah.com> <200412201501.12575.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412201501.12575.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2004 at 03:01:12PM -0800, Jesse Barnes wrote:
> > What happens if mmap is not set?  oops...
> 
> Yeah, I mentioned that in "things to do" at the bottom, but I'm really looking 
> for an "ack, this is a sane way to go" before I sink much more time into it.

I think this is a sane way to go.

How about sending me a patch just to add the mmap support to binary
sysfs files now?  I'll be glad to add that to my trees.

Then you can work on the pci stuff over time.

Sound good?

thanks,

greg k-h
