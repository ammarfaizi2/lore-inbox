Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbWGCSUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbWGCSUV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 14:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbWGCSUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 14:20:21 -0400
Received: from cantor2.suse.de ([195.135.220.15]:31908 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932088AbWGCSUV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 14:20:21 -0400
Date: Mon, 3 Jul 2006 11:16:21 -0700
From: Greg KH <gregkh@suse.de>
To: Andy Gay <andy@andynet.net>
Cc: Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, Ken Brush <kbrush@gmail.com>,
       Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] Airprime driver improvements to allow full speed EvDO transfers
Message-ID: <20060703181621.GA8448@suse.de>
References: <1151646482.3285.410.camel@tahini.andynet.net> <adad5cnderb.fsf@cisco.com> <1151872141.3285.486.camel@tahini.andynet.net> <20060703170040.GA15315@suse.de> <1151949329.3285.545.camel@tahini.andynet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151949329.3285.545.camel@tahini.andynet.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2006 at 01:55:28PM -0400, Andy Gay wrote:
> On Mon, 2006-07-03 at 10:00 -0700, Greg KH wrote:
> > Yes, this driver is already split into 2 different ones (look in the
> > recent -mm releases).  Sierra wants to have their devices be in their
> > own driver, as the chip is a little different from the other ones.  This
> > means that those devices are now controlled by a driver called "sierra"
> > and the other devices still are working with the airprime driver.
> > 
> > This should hopefully fix the different endpoint issue, and allow new
> > devices to be supported properly, as Sierra Wireless is now maintaining
> > that driver.
> Aha, good news. So this patch is already obsolete, for the Sierra stuff
> anyway. And as I only have Sierra kit to work with, I reckon I should
> drop out of this now.

No, not at all.  I'll gladly add your patch to the sierra driver, if you
say it works for your devices.

> I did make some changes to the last patch to do the cleanup stuff in the
> open function, do you want to see those?

Yes, please send the latest version, and I'll apply it.

thanks,

greg k-h
