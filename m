Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161285AbWGNSuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161285AbWGNSuS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 14:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161286AbWGNSuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 14:50:18 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:42511 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1161285AbWGNSuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 14:50:17 -0400
Date: Fri, 14 Jul 2006 14:50:16 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andy Chittenden <AChittenden@bluearc.com>
cc: Andrew Morton <akpm@osdl.org>, David Brownell <david-b@pacbell.net>,
       Greg KH <greg@kroah.com>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] 2.6.17 hangs during boot on ASUS M2NPV-VM
 motherboard
In-Reply-To: <20060714093014.2a6e68ff.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44L0.0607141447320.8006-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2006, Andrew Morton wrote:

> On Fri, 14 Jul 2006 16:54:25 +0100
> "Andy Chittenden" <AChittenden@bluearc.com> wrote:

> > > So I guess there's something awry with the USB controller driver?
> > > 
> > 
> > Is there any other info that someone wants to track this down? Or has
> > someone got a fix?

It's hard to come up with a fix without knowing what's wrong.  The current 
development version of that subroutine is essentially the same as the 
version in 2.6.17.

If you want to pin down the problem more precisely, try adding a whole 
bunch of printk() statements to the quirk_usb_handoff_ohci() function in
drivers/usb/host/pci-quirks.c.

Alan Stern

