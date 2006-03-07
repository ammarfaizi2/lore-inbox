Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751339AbWCGRWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbWCGRWh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 12:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbWCGRWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 12:22:37 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:1727 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1751339AbWCGRWg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 12:22:36 -0500
Date: Tue, 7 Mar 2006 09:22:29 -0800
From: Greg KH <greg@kroah.com>
To: wixor <wixorpeek@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: using usblp with ppdev?
Message-ID: <20060307172229.GB7293@kroah.com>
References: <c43b2e150603020732m42195b0dkf33d68fe64bc4a57@mail.gmail.com> <20060302165557.GA31247@kroah.com> <c43b2e150603030512l141c101va11300bcfbda4f60@mail.gmail.com> <20060303170752.GA5260@kroah.com> <c43b2e150603060631h494b920g84cf357f376d64bb@mail.gmail.com> <20060306172532.GB8697@kroah.com> <c43b2e150603070902l10659822ib6ffe1c4b0b296bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c43b2e150603070902l10659822ib6ffe1c4b0b296bf@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2006 at 06:02:12PM +0100, wixor wrote:
> >
> > But if you want to play around and verify this, try modifying the USB
> > device table in the drivers/usb/misc/uss720.c file (look for the
> > structure called "uss720_table" and add a new entry with the vendor and
> > product id of your device there.)
> >
> Well, it seems the device doesn't like the driver or vice-verse. When
> added entry to the uss720_table, /proc/bus/usb/devices reports that
> the device is being handled by this driver, but when I plug the device
> in, dmesg gets full of error reports, and the device file doesn't
> appear in /dev .

Ok, then your device is not of this type and will not work, sorry.  I
suggest you go purchase a uss720 based device if you wish to do this
kind of thing.

> Now, my question is: is the cable named "usb to
> parallel cable" an interface that converts classic printer to usb
> printer? Shouldn't it be rather a real usb to parallel cable?

As the manufacturer about this, we have no idea :)

thanks,

greg k-h
