Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266170AbUGJJV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266170AbUGJJV1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 05:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266147AbUGJJV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 05:21:27 -0400
Received: from mail001.syd.optusnet.com.au ([211.29.132.142]:41192 "EHLO
	mail001.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266170AbUGJJVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 05:21:03 -0400
Message-Id: <200407100920.i6A9Kr808614@mail001.syd.optusnet.com.au>
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: binary
MIME-Version: 1.0
X-Mailer: MIME-tools 5.411 (Entity 5.404)
From: Robert Lowery <rlowery@optusnet.com.au>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Sat, 10 Jul 2004 19:20:53 +1000
Subject: Re: Re: [OT] Belkin Bluetooth Access Point GPL violation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

At this point, I have not tried pulling the firmware apart, all I have done is telnetted into 
it and poked around a bit.

If I manage to get the kernel source, my next step will be to try and work out how to 
pull apart their firmware and repackage it with a custom kernel.

-Robert

> Marcel Holtmann <marcel@holtmann.org> wrote:
> 
> Hi Robert,
> 
> > I recently purchase a Belkin Bluetooth Access Point with USB Print
> > Server
> > 
> http://catalog.belkin.com/IWCatProductPage.process?Merchant_Id=&Section_
> 
> > Id=200583&pcount=&Product_Id=134669
> > 
> > By telnetting into it, I was able to find that it runs linux,
> > specifically uClinux version 2.0.38.1pre7arm.
> > 
> > Investigating further, I found the device is made by
> > www.rovingnetworks.com
> > 
> > The latest version of firmware may be obtained from
> > http://www.belkin.com/firmware/bluetooth/f8t030/flash.bin or a beta
> > version that includes PAN support at
> > www.rovingnetworks.com/belkinpan4.bin
> > 
> > I contacted them at support@rovingnetworks.com  Mike Conrad replied 
> to
> > my request.
> > 
> > Initially, he said they wanted $5000 for a source code license.  When 
> I
> > Informed him of their GPL violation, he said
> > "you could possibly have the linux os changes we made, but our 
> bluetooth
> > stack, for example, is not covered under the GPL. And we have special
> > tools that enable web download, and  create the image that is loaded,
> > etc."
> > 
> > Looking at the running system, it is not running any kernel modules, 
> so
> > I would expect the bluetooth stack to be compiled into the kernel
> > proper, which in my understanding would mean they have to release the
> > source.
> 
> may you tell me how you extracted the kernel and the filesystem from 
> the
> firmware files. I wanna take a look at it and find out what Bluetooth
> stack they are using.
> 
> Regards
> 
> Marcel
