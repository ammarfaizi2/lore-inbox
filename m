Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265232AbSJRQKZ>; Fri, 18 Oct 2002 12:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265226AbSJRQJz>; Fri, 18 Oct 2002 12:09:55 -0400
Received: from momus.sc.intel.com ([143.183.152.8]:33748 "EHLO
	momus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S265221AbSJRQJE>; Fri, 18 Oct 2002 12:09:04 -0400
Message-ID: <D1C0BF20D4AFD411AB98009027AE99881167C7C8@fmsmsx40.fm.intel.com>
From: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
To: "'Dave Jones'" <davej@codemonkey.org.uk>, Greg KH <greg@kroah.com>
Cc: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "Patterson, David H" <david.h.patterson@intel.com>,
       "Carbonari, Steven" <steven.carbonari@intel.com>,
       "Abel, Michael J" <michael.j.abel@intel.com>,
       "Tarabini, Anthony" <anthony.tarabini@intel.com>,
       "'andreasW@ati.com'" <andreasW@ati.com>,
       "Abdul-Khaliq, Rushdan" <rushdan.abdul-khaliq@intel.com>
Subject: RE: [PATCH] GART driver support for generic AGP 3.0 device detect
	ion/ enabling & Intel 7505 chipset support
Date: Fri, 18 Oct 2002 09:14:00 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The AMD 8151 is AGP 3.0 compliant too, but the current driver is just
> the page remapping support.  It's possible that some functionality
> implemented both there and in agp3.c can be propagated both ways.

Greg, Dave, Please let me know if/how I can assist in this regard.  The idea
was to 
free specific chipset implemenations from having to duplicate this generic
code w/o further bloating agp.c.  


> Despite it being support for a major protocol version bump, it's
> still just another driver, which means it could go in after the
> freeze if needbe.
> 
> Looks fine for merging afaics though.
> 

Great!  Thanks...

matt
