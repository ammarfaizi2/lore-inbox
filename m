Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261527AbSJRO4x>; Fri, 18 Oct 2002 10:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265110AbSJRO4x>; Fri, 18 Oct 2002 10:56:53 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:14250 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261527AbSJRO4w>;
	Fri, 18 Oct 2002 10:56:52 -0400
Date: Fri, 18 Oct 2002 16:04:17 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Greg KH <greg@kroah.com>
Cc: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "Patterson, David H" <david.h.patterson@intel.com>,
       "Carbonari, Steven" <steven.carbonari@intel.com>,
       "Abel, Michael J" <michael.j.abel@intel.com>,
       "Tarabini, Anthony" <anthony.tarabini@intel.com>,
       "'andreasW@ati.com'" <andreasW@ati.com>,
       "Abdul-Khaliq, Rushdan" <rushdan.abdul-khaliq@intel.com>
Subject: Re: [PATCH] GART driver support for generic AGP 3.0 device detection/ enabling & Intel 7505 chipset support
Message-ID: <20021018150417.GA23741@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Greg KH <greg@kroah.com>,
	"Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	"Patterson, David H" <david.h.patterson@intel.com>,
	"Carbonari, Steven" <steven.carbonari@intel.com>,
	"Abel, Michael J" <michael.j.abel@intel.com>,
	"Tarabini, Anthony" <anthony.tarabini@intel.com>,
	"'andreasW@ati.com'" <andreasW@ati.com>,
	"Abdul-Khaliq, Rushdan" <rushdan.abdul-khaliq@intel.com>
References: <D1C0BF20D4AFD411AB98009027AE99881167C7BF@fmsmsx40.fm.intel.com> <20021018035720.GA3326@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021018035720.GA3326@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2002 at 08:57:20PM -0700, Greg KH wrote:

 > You should probably not build agp3.o unless i7505-agp.o is built too, or
 > do some of the other drivers need functions in agp3.c?

The AMD 8151 is AGP 3.0 compliant too, but the current driver is just
the page remapping support.  It's possible that some functionality
implemented both there and in agp3.c can be propagated both ways.

I'll look into this next week.
Despite it being support for a major protocol version bump, it's
still just another driver, which means it could go in after the
freeze if needbe.

Looks fine for merging afaics though.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
