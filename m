Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129239AbQKIRHL>; Thu, 9 Nov 2000 12:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129459AbQKIRHB>; Thu, 9 Nov 2000 12:07:01 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:37649 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S129239AbQKIRGw>; Thu, 9 Nov 2000 12:06:52 -0500
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDC82@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'David Ford'" <david@linux.com>, Greg KH <greg@wirex.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: [bug] usb-uhci locks up on boot half the time
Date: Thu, 9 Nov 2000 09:06:31 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: David Ford [mailto:david@linux.com]
> 
[snip]
> > Is the external hub a externally powered hub, or self 
> powered hub (does
> > it get it's power from a plug in the wall, or from the USB 
> bus)?  Self
> > powered hubs are notoriously flaky and have been known to 
> > evil things to the USB bus.
> 
> Either.  Currently bus (self) powered.  This hub has worked 
> fine on my other
> computers without any adverse affect.

Bus-powered != self-powered.

Self-powered means that it has its own power cord.

Bus-powered means that it gets its power from the USB cable.

Unlike Greg, I would have said that bus-powered hubs
can be a problem -- especially when you plug too many
devices into them that need lots of power.  What we saw
at the USB PlugFest was hubs just shutting down when
we did this.  :(

~Randy

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
