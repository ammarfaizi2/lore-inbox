Return-Path: <linux-kernel-owner+w=401wt.eu-S1755374AbXABQuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755374AbXABQuT (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 11:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755378AbXABQuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 11:50:18 -0500
Received: from xenotime.net ([66.160.160.81]:36219 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755374AbXABQuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 11:50:17 -0500
Date: Tue, 2 Jan 2007 08:36:50 -0800
From: Randy Dunlap <rdunlap@xenotime.net>
To: Andrew Barr <andrew.james.barr@gmail.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: Cut power to a USB port?
Message-Id: <20070102083650.c8a73253.rdunlap@xenotime.net>
In-Reply-To: <1167751719.2653.7.camel@localhost>
References: <1167684985.28023.4.camel@localhost>
	<20070102083258.GA24516@kroah.com>
	<1167751719.2653.7.camel@localhost>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Jan 2007 10:28:38 -0500 Andrew Barr wrote:

> On Tue, 2007-01-02 at 00:32 -0800, Greg KH wrote:
> > On Mon, Jan 01, 2007 at 03:56:25PM -0500, Andrew Barr wrote:
> > > I have a simple question perhaps someone can help me with here...
> > > 
> > > I have one of those simple LED keyboard lamps that get their power from
> > > the USB port. Is there some way in Linux, using files under /sys I would
> > > imagine, to cut power to the USB port into which this lamp is plugged? I
> > > know I would have to manually figure out what port it's plugged into, as
> > > it is not a "real" USB device...e.g. it just draws power. I would like
> > > to be able to programmatically switch the lamp on and off.
> > 
> > Search the archives of the linux-usb-devel mailing list for a program
> > that might do this for you (depending on your hardware.)
> 
> What search terms should I use? Searching on "power" and "port power" at
> Gmane in the gmane.linux.usb.devel group doesn't readily give me
> anything.

You can try:

usbpoweroff.c
(http://www.informatik.uni-halle.de/~ladischc/usbpoweroff.c)
or
hub-ctrl-2.c (http://www.gniibe.org/log/linux)

> For the record, my hardware:
> 
> 00:1d.0 USB Controller: Intel Corporation 82801DB/DBL/DBM
> (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 01)
> 00:1d.1 USB Controller: Intel Corporation 82801DB/DBL/DBM
> (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 01)
> 00:1d.2 USB Controller: Intel Corporation 82801DB/DBL/DBM
> (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 01)
> 00:1d.7 USB Controller: Intel Corporation 82801DB/DBM (ICH4/ICH4-M) USB2
> EHCI Controller (rev 01)
> 
> IBM Thinkpad R51 2883-ELU.


---
~Randy
