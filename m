Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbWINRgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbWINRgt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 13:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbWINRgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 13:36:49 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:46297 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750786AbWINRgs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 13:36:48 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] 2.6.18-rc6-mm1 (-mm2): ohci resume problem
Date: Thu, 14 Sep 2006 19:35:52 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Mattia Dongili <malattia@linux.it>,
       Robert Hancock <hancockr@shaw.ca>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
References: <Pine.LNX.4.44L0.0609141320020.5715-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0609141320020.5715-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609141935.53605.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 14 September 2006 19:22, Alan Stern wrote:
> On Thu, 14 Sep 2006, Rafael J. Wysocki wrote:
> 
> > Now USB didn't work after the first resume (kernel configured with USB_SUSPEND
> > unset).
> > 
> > The dmesg output is attached.
> 
> This is getting too confusing.  :-(

Sorry for the confusion.

> Let's try a simpler test.  Leave USB_SUSPEND unset.
> 
> First rmmod ohci-hcd.  None of your full-speed USB devices will work, but 
> that's okay.  Try the suspend-twice test and see what happens.
> 
> Second, rmmod ehci-hcd and modprobe ohci-hcd.  Again try the suspend-twice 
> test.

Done, works (with USB_SUSPEND unset).

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
