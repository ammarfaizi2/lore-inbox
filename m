Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261609AbULBNeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbULBNeo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 08:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261616AbULBNen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 08:34:43 -0500
Received: from [213.146.154.40] ([213.146.154.40]:20119 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261609AbULBNem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 08:34:42 -0500
Date: Thu, 2 Dec 2004 13:34:37 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: kuba@mareimbrium.org, greg@kroah.com, bryder@sgi.com,
       linux-kernel@vger.kernel.org, edwin@harddisk-recovery.nl
Subject: Re: FTDI SIO patch to allow custom vendor/product IDs.
Message-ID: <20041202133437.GA27994@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Rogier Wolff <R.E.Wolff@BitWizard.nl>, kuba@mareimbrium.org,
	greg@kroah.com, bryder@sgi.com, linux-kernel@vger.kernel.org,
	edwin@harddisk-recovery.nl
References: <20041202124831.GA31745@bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041202124831.GA31745@bitwizard.nl>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
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

I think it would be much better to have something like the dynamic PCI IDs
support to USB aswell.

