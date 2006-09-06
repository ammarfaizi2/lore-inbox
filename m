Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbWIFKyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbWIFKyN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 06:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWIFKyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 06:54:12 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:14992 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1750779AbWIFKyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 06:54:10 -0400
Date: Wed, 6 Sep 2006 12:54:15 +0200
From: Pavel Machek <pavel@suse.cz>
To: Adam Belay <abelay@novell.com>
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
       arjan@linux.intel.com
Subject: Re: [RFC][PATCH 2/2] ACPI: handle timer ticks proactively
Message-ID: <20060906105415.GG4987@atrey.karlin.mff.cuni.cz>
References: <20060904131027.GD6279@ucw.cz> <20060905082855.GC5082@elf.ucw.cz> <20060905085319.GA2237@elf.ucw.cz> <20060905090328.GA4888@elf.ucw.cz> <1157469360.3420.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157469360.3420.14.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Okay, just to get you some feedback:
> > > 
> > > It seems to change things a _lot_. Power consumption with usb modules
> > > loaded went from 14315mW to 13800mW -- that is huge
> > > deal. Unfortunately something strange is going on: with stock kernel,
> > > power consumption is mostly constant. With your patch, it varies a
> > > lot, at 2 second timescale.
> > > 
> > > Power consumption with usb unloaded (only way to get reasonable power
> > > on x60) went from stable 10450mW to  something rapidly changing, and
> > > probably even worse than original:
> > 
> > I also noticed that with your patch, bus master activity tends to be constant?!
> 
> Is this the case even when userspace touches the disk?  On my hardware I
> see a constant flow of short BM activity bursts.

Disk was active (like once 5 seconds some small access)...
									Pavel
-- 
Thanks, Sharp!
