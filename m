Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264069AbTFTSTh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 14:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264072AbTFTSTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 14:19:37 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:15013 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264069AbTFTSTg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 14:19:36 -0400
Date: Fri, 20 Jun 2003 11:32:51 -0700
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Patrick Mochel <mochel@osdl.org>, Mike Anderson <andmike@us.ibm.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Flaw in the driver-model implementation of attributes
Message-ID: <20030620183251.GB12509@kroah.com>
References: <20030619213109.GB5644@kroah.com> <Pine.LNX.4.44L0.0306201020240.917-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0306201020240.917-100000@ida.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 20, 2003 at 10:22:21AM -0400, Alan Stern wrote:
> > Why not hold off until the scsi people are finished with their changes?
> > If after that, you _really_ need to be putting usb-storage only
> > attributes in the sysfs tree somewhere, we can talk again.
> 
> Sounds reasonable.  By the way, do you plan to create a 
> /sys/class/usb_host/ class for the OHCI and ECHI drivers?

Yes, and for the UHCI driver too :)

Unless someone else wants to send me a patch...

thanks,

greg k-h
