Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317253AbSHOQkU>; Thu, 15 Aug 2002 12:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317257AbSHOQkU>; Thu, 15 Aug 2002 12:40:20 -0400
Received: from air-2.osdl.org ([65.172.181.6]:25304 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S317253AbSHOQkU>;
	Thu, 15 Aug 2002 12:40:20 -0400
Date: Thu, 15 Aug 2002 09:48:55 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: driverfs: [PATCH] remove bus and improve driver management
 (2.5.30)
In-Reply-To: <20020815162308.GC32542@kroah.com>
Message-ID: <Pine.LNX.4.44.0208150944530.1241-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> A bus is different than a driver, as drivers bind to the bus type.  In a
> way, you can say a bus is nothing more than a "class", and class support
> _is_ coming soon.  I think class support is what you are really looking
> for, as it will be able to show you the relationship between devices
> much better.

BTW, for the restless and curious, there is a BK tree available that has 
preliminary class and interface support in it. I'm relatively satisfied 
with the way things are starting to fall out in it, so if anyone wants to 
start taking a look and give me some feedback, that'd be great. 

Note that it's still very immature, and lacking documentation. But, for 
people that are already playing with it, have at it:

	bk://ldm.bkbits.net/linux-2.5-devclass


	-pat

