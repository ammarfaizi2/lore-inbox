Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261698AbULBSK6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261698AbULBSK6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 13:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbULBSK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 13:10:56 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:26105 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261698AbULBSI4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 13:08:56 -0500
Date: Thu, 2 Dec 2004 10:00:12 -0800
From: Greg KH <greg@kroah.com>
To: Christoph Hellwig <hch@infradead.org>,
       Rogier Wolff <R.E.Wolff@BitWizard.nl>, kuba@mareimbrium.org,
       bryder@sgi.com, linux-kernel@vger.kernel.org,
       edwin@harddisk-recovery.nl
Subject: Re: FTDI SIO patch to allow custom vendor/product IDs.
Message-ID: <20041202180012.GD7655@kroah.com>
References: <20041202124831.GA31745@bitwizard.nl> <20041202133437.GA27994@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041202133437.GA27994@infradead.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2004 at 01:34:37PM +0000, Christoph Hellwig wrote:
> On Thu, Dec 02, 2004 at 01:48:31PM +0100, Rogier Wolff wrote:
> > 
> > To prevent XP from hijacking devices that require a different driver,
> > some people flash a different Vendor/Product ID into their FTDI based
> > device. 
> > 
> > Also some "new" devices may come out which are perfectly valid to be
> > driven by the ftdi_sio driver, but happen to have a vendor/product
> > id which is not (yet) included in the driver.  I've built a patch
> > that allows you to tell the driver "vendor=... product=...." to 
> > make it accept such devices.
> > 
> > Does this patch make sense?
> 
> I think it would be much better to have something like the dynamic PCI IDs
> support to USB aswell.

I agree, and this is what I have stated a number of times already.  But
it's going to take some driver core rework to get correct, and I'm
finding less time than I expected in order to do that work...

Hopefully soon...

thanks,

greg k-h
