Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278660AbRKHWM7>; Thu, 8 Nov 2001 17:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278665AbRKHWMj>; Thu, 8 Nov 2001 17:12:39 -0500
Received: from dire.bris.ac.uk ([137.222.10.60]:22769 "EHLO dire.bris.ac.uk")
	by vger.kernel.org with ESMTP id <S278660AbRKHWMc>;
	Thu, 8 Nov 2001 17:12:32 -0500
Date: Thu, 8 Nov 2001 22:10:57 +0000 (GMT)
From: Matt <madmatt@bits.bris.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: WOL stops working on halt
In-Reply-To: <3BEAC5E2.5A301DB@zip.com.au>
Message-ID: <Pine.LNX.4.21.0111082139390.32072-100000@bits.bris.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton mentioned the following:

| Matt wrote:
| > 
| > I have a 3c980 NIC plugged into an Abit KT7-RAID and connected together
| > with a WOL cable. I can't seem to get WOL to work using the ether-wake
| > utility if I power the box down with shutdown(8). The only way I can
| > currently get WOL to work is if I reboot the box, then physically press
| > the power button to turn it off.
| 
| As far as the driver is concerned, a shutdown and a reboot are identical,
| so we need to look at external causes.  Presumably Linux APM or BIOS.

I've looked through the BIOS settings, and there doesn't seem to be much I
can change. There was one option to toggle "ACPI Suspend" between S3 and
S5 I think, and another which was something like "PM by APM", which could
be set to either Y or N. I'm not sure what other options I should be
looking for which might make a difference...I can't see anything obvios.

I've tried enabling ACPI support, but that has succeeded in confusing me
as I can't work out how to use it, acpid seems to do nothing.

Even without APM support compiled in, the box still manages to turn itself
off, (running poweroff), and every time it won't respond to WOL. In all
cases, the card is still powered up and negotiated to the switch.

Matt
-- 
"Phase plasma rifle in a forty-watt range?"
"Only what you see on the shelves, buddy."


