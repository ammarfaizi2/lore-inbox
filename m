Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261689AbULBSKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbULBSKb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 13:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbULBSKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 13:10:30 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:957 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261702AbULBSI5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 13:08:57 -0500
Date: Thu, 2 Dec 2004 10:00:53 -0800
From: Greg KH <greg@kroah.com>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: kuba@mareimbrium.org, bryder@sgi.com, linux-kernel@vger.kernel.org,
       edwin@harddisk-recovery.nl
Subject: Re: FTDI SIO patch to allow custom vendor/product IDs.
Message-ID: <20041202180053.GE7655@kroah.com>
References: <20041202124831.GA31745@bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041202124831.GA31745@bitwizard.nl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2004 at 01:48:31PM +0100, Rogier Wolff wrote:
> 
> To prevent XP from hijacking devices that require a different driver,
> some people flash a different Vendor/Product ID into their FTDI based
> device. 
> 
> Also some "new" devices may come out which are perfectly valid to be
> driven by the ftdi_sio driver, but happen to have a vendor/product
> id which is not (yet) included in the driver.  I've built a patch
> that allows you to tell the driver "vendor=... product=...." to 
> make it accept such devices.
> 
> Does this patch make sense?
> 
> I've built this patch for 2.4.28, but I'll port it for inclusion into
> 2.6 if people agree that this is useful.

Looks fine to me for 2.4, care to make a 2.6 patch too?

thanks,

greg k-h
