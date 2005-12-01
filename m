Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbVLAHus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbVLAHus (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 02:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbVLAHus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 02:50:48 -0500
Received: from smtp2-g19.free.fr ([212.27.42.28]:27293 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750750AbVLAHur (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 02:50:47 -0500
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] [PATCH] Additional device ID for Conexant AccessRunner USB driver
Date: Thu, 1 Dec 2005 08:50:42 +0100
User-Agent: KMail/1.9
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       davej@redhat.com
References: <1133330317951@kroah.com> <200511300909.06843.duncan.sands@math.u-psud.fr> <20051130223015.GC16416@kroah.com>
In-Reply-To: <20051130223015.GC16416@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512010850.42544.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 November 2005 23:30, Greg KH wrote:
> On Wed, Nov 30, 2005 at 09:09:06AM +0100, Duncan Sands wrote:
> > > diff --git a/drivers/usb/atm/cxacru.c b/drivers/usb/atm/cxacru.c
> > > index 79861ee..9d59dc6 100644
> > > --- a/drivers/usb/atm/cxacru.c
> > > +++ b/drivers/usb/atm/cxacru.c
> > > @@ -787,6 +787,9 @@ static const struct usb_device_id cxacru
> > >  	{ /* V = Conexant			P = ADSL modem (Hasbani project)	*/
> > >  		USB_DEVICE(0x0572, 0xcb00),	.driver_info = (unsigned long) &cxacru_cb00
> > >  	},
> > > +	{ /* V = Conexant             P = ADSL modem (Well PTI-800 */
> > > +		USB_DEVICE(0x0572, 0xcb02),	.driver_info = (unsigned long) &cxacru_cb00
> > > +	},
> > >  	{ /* V = Conexant			P = ADSL modem				*/
> > >  		USB_DEVICE(0x0572, 0xcb01),	.driver_info = (unsigned long) &cxacru_cb00
> > >  	},
> > 
> > The whitespace is mucked up, and a closing bracket is missing after Well PTI-800...
> > 
> > Try this:
> > 
> > Signed-off-by: Duncan Sands <baldrick@free.fr>
> 
> Linus already applied the original version, care to make up a "fix up
> whitespace" patch on top of that?

OK.  I'll send it later along with some other improvements we've been working on.

Ciao,

Duncan.
