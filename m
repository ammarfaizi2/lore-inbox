Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264756AbTGBV6Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 17:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbTGBV6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 17:58:24 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:2954 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S264756AbTGBV6W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 17:58:22 -0400
Date: Wed, 2 Jul 2003 15:12:19 -0700
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Flaw in the driver-model implementation of attributes
Message-ID: <20030702221219.GB10072@kroah.com>
References: <20030619213109.GB5644@kroah.com> <Pine.LNX.4.44L0.0306201020240.917-100000@ida.rowland.org> <20030620183251.GB12509@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030620183251.GB12509@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 20, 2003 at 11:32:51AM -0700, Greg KH wrote:
> On Fri, Jun 20, 2003 at 10:22:21AM -0400, Alan Stern wrote:
> > > Why not hold off until the scsi people are finished with their changes?
> > > If after that, you _really_ need to be putting usb-storage only
> > > attributes in the sysfs tree somewhere, we can talk again.
> > 
> > Sounds reasonable.  By the way, do you plan to create a 
> > /sys/class/usb_host/ class for the OHCI and ECHI drivers?
> 
> Yes, and for the UHCI driver too :)
> 
> Unless someone else wants to send me a patch...

This is now in 2.5.74.  Combined with the module reference patch for
attributes that I just posted I now think that the problems discussed in
this thread are solved, right?

thanks,

greg k-h
