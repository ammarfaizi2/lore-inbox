Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266441AbTGJUKX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 16:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266446AbTGJUKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 16:10:23 -0400
Received: from [212.209.10.216] ([212.209.10.216]:59050 "EHLO
	krynn.se.axis.com") by vger.kernel.org with ESMTP id S266441AbTGJUKW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 16:10:22 -0400
Message-ID: <3C6BEE8B5E1BAC42905A93F13004E8AB03277AA5@mailse01.axis.se>
From: Mikael Starvik <mikael.starvik@axis.com>
To: "'Greg KH'" <greg@kroah.com>, "'Mikael Starvik'" <mikael.starvik@axis.com>
Cc: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: CRIS architecture update
Date: Thu, 10 Jul 2003 22:24:56 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Speaking of older kernels, any chances for a 2.5 update? 

Yes. I have sent patches to Linus several times, the latest one today.
So far he has been dropping my patches on the floor.

So far our 2.5 tree doesn't have a USB driver because I 
would like to wait until the USB framework is less volatile.
In my mind we will port the USB driver somewhere around
2.6.0.

/Mikael

-----Original Message-----
From: Greg KH [mailto:greg@kroah.com]
Sent: Thursday, July 10, 2003 7:15 PM
To: Mikael Starvik
Cc: 'Linux Kernel Mailing List'
Subject: Re: CRIS architecture update


On Thu, Jul 10, 2003 at 10:13:41AM -0700, Greg KH wrote:
> On Thu, Jul 10, 2003 at 07:24:58AM +0200, Mikael Starvik wrote:
> > Ok, do you have any other suggestion on how to make the driver 
> > compilable for both >= 2.4.20 and < 2.4.20?
> 
> As the driver is _in_ the kernel tree, why does it need to be compilable
> for older kernels?  :)

Speaking of older kernels, any chances for a 2.5 update?  I know the
CRIS USB host controller driver has fallen pretty out of date with the
rest of the USB core, and would hope to see that sync up sometime.

thanks,

greg k-h
