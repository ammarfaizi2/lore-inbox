Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261906AbVGaVTS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbVGaVTS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 17:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261908AbVGaVTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 17:19:18 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:27758 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261906AbVGaVTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 17:19:17 -0400
Date: Sun, 31 Jul 2005 14:19:01 -0700
From: Greg KH <gregkh@suse.de>
To: Markus Lidel <Markus.Lidel@shadowconnect.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: sysfs abuse in recent i2o changes
Message-ID: <20050731211901.GC17363@suse.de>
References: <20050628112102.GA1111@lst.de> <42C16691.3090205@shadowconnect.com> <20050628162125.GA9239@suse.de> <42C19214.6070708@shadowconnect.com> <20050628180719.GA11585@suse.de> <42C25CBF.8000509@shadowconnect.com> <20050708060028.GB5323@suse.de> <20050731140939.GB25958@lst.de> <42ECF0ED.9070007@shadowconnect.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42ECF0ED.9070007@shadowconnect.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 31, 2005 at 05:40:29PM +0200, Markus Lidel wrote:
> Hello,
> 
> Christoph Hellwig wrote:
> >So folks, this is still in 2.6.13-rc4, shouldn't we pull it out so we
> 
> Yep, sorry... I'll try to send the patch during next week...
> 
> >don't add an interface soon to be removed again to 2.6.13?
> 
> The interface will still be available, because IMHO it fits better then 
> the old ioctl based one... But until the necessary functions for the 
> interface are available, i'll provide a separate patch, which could be 
> downloaded at the I2O website...

What "necessary functions for the interface"?  Remember, you are not
using sysfs properly, so please fix your code to not do that anymore.

thanks,

greg k-h
