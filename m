Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964937AbWF3DDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964937AbWF3DDG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 23:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964935AbWF3DDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 23:03:06 -0400
Received: from mail.kroah.org ([69.55.234.183]:63172 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964937AbWF3DDB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 23:03:01 -0400
Date: Thu, 29 Jun 2006 20:02:43 -0700
From: Greg KH <gregkh@suse.de>
To: Andy Gay <andy@andynet.net>
Cc: Roland Dreier <rdreier@cisco.com>, Jeremy Fitzhardinge <jeremy@goop.org>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: USB driver for Sierra Wireless EM5625/MC5720 1xEVDO modules
Message-ID: <20060630030243.GB5049@suse.de>
References: <1151537247.3285.278.camel@tahini.andynet.net> <20060630021332.GB30911@suse.de> <adabqsbfjrn.fsf@cisco.com> <1151635897.3285.394.camel@tahini.andynet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151635897.3285.394.camel@tahini.andynet.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2006 at 10:51:37PM -0400, Andy Gay wrote:
> On Thu, 2006-06-29 at 19:40 -0700, Roland Dreier wrote:
> >  > or:
> >  >   - send a patch against 2.6.17 that is my changes + your fixes to
> >  >     actually make it work.
> >  > 
> >  > My patch was just a "throw it out there and see what works or not", as I
> >  > don't even have the device to test it with.
> > 
> > I would love to see such a patch.  I have a Kyocera KPC650 and I would
> > love to get better performance with it under Linux...
> Hmm. That's not one of the current list of devices this driver supports.
> Is it a usb-serial interface like the other Airprime stuff?

Here's the needed line to support this device, someone has already sent
me a patch adding it:

        { USB_DEVICE(0x0c88, 0x17da) }, /* Kyocera Wireless KPC650/Passport */

thanks,

greg k-h
