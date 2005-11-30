Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbVK3XIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbVK3XIe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 18:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbVK3XIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 18:08:34 -0500
Received: from mail.kroah.org ([69.55.234.183]:6093 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751249AbVK3XId (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 18:08:33 -0500
Date: Wed, 30 Nov 2005 14:30:15 -0800
From: Greg KH <greg@kroah.com>
To: Duncan Sands <duncan.sands@math.u-psud.fr>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       davej@redhat.com
Subject: Re: [linux-usb-devel] [PATCH] Additional device ID for Conexant AccessRunner USB driver
Message-ID: <20051130223015.GC16416@kroah.com>
References: <1133330317951@kroah.com> <200511300909.06843.duncan.sands@math.u-psud.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511300909.06843.duncan.sands@math.u-psud.fr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2005 at 09:09:06AM +0100, Duncan Sands wrote:
> > diff --git a/drivers/usb/atm/cxacru.c b/drivers/usb/atm/cxacru.c
> > index 79861ee..9d59dc6 100644
> > --- a/drivers/usb/atm/cxacru.c
> > +++ b/drivers/usb/atm/cxacru.c
> > @@ -787,6 +787,9 @@ static const struct usb_device_id cxacru
> >  	{ /* V = Conexant			P = ADSL modem (Hasbani project)	*/
> >  		USB_DEVICE(0x0572, 0xcb00),	.driver_info = (unsigned long) &cxacru_cb00
> >  	},
> > +	{ /* V = Conexant             P = ADSL modem (Well PTI-800 */
> > +		USB_DEVICE(0x0572, 0xcb02),	.driver_info = (unsigned long) &cxacru_cb00
> > +	},
> >  	{ /* V = Conexant			P = ADSL modem				*/
> >  		USB_DEVICE(0x0572, 0xcb01),	.driver_info = (unsigned long) &cxacru_cb00
> >  	},
> 
> The whitespace is mucked up, and a closing bracket is missing after Well PTI-800...
> 
> Try this:
> 
> Signed-off-by: Duncan Sands <baldrick@free.fr>

Linus already applied the original version, care to make up a "fix up
whitespace" patch on top of that?

thanks,

greg k-h
