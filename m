Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751573AbWDARc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573AbWDARc5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 12:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751575AbWDARc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 12:32:57 -0500
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:37537 "HELO
	smtp109.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751573AbWDARc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 12:32:57 -0500
From: David Brownell <david-b@pacbell.net>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Handling devices that don't have a bus
Date: Sat, 1 Apr 2006 09:32:54 -0800
User-Agent: KMail/1.7.1
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Greg KH <greg@kroah.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.0604011128020.17557-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0604011128020.17557-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604010932.55104.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 01 April 2006 8:46 am, Alan Stern wrote:

> I think you have misunderstood my point.  Yes, devices are part of the
> platform bus only if they explicitly want to be.  My point was that even
> though they _do_ want to be on the platform bus, 

I'm not clear on why it would want to be on the platform bus;
what would its inner platform-ness consist of?

There really isn't a "bus" that makes much sense for such a
singleton device to sit on.  


> in this situation they 
> _can't_ because they are forced to register a struct device, not a struct
> platform_device.  The choice is not up to the driver; it is determined by
> the USB Gadget framework. 

