Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750938AbWJHIjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbWJHIjS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 04:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbWJHIjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 04:39:18 -0400
Received: from smtp-out001.kontent.com ([81.88.40.215]:45486 "EHLO
	smtp-out.kontent.com") by vger.kernel.org with ESMTP
	id S1750938AbWJHIjR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 04:39:17 -0400
From: Oliver Neukum <oliver@neukum.org>
To: David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] error to be returned while suspended
Date: Sun, 8 Oct 2006 10:39:58 +0200
User-Agent: KMail/1.8
References: <Pine.LNX.4.44L0.0610051631550.7144-100000@iolanthe.rowland.org> <200610080838.03488.oliver@neukum.org> <200610080020.49158.david-b@pacbell.net>
In-Reply-To: <200610080020.49158.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610081039.59777.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 8. Oktober 2006 09:20 schrieb David Brownell:
> > If a device is always opened, as mice are, it will not be suspended.
> > Yet they can be without any data to deliver forever.
> 
> In 2.6.19-rc1 read Documentation/power/devices.txt about runtime
> suspend states.  Then think about how why mouse in a runtime suspend
> state, with remote wakeup enabled, looks externally ** EXACTLY ** like
> a mouse that's fully active ....

I've done so. And I've read the HID spec. It just says that a mouse
may support remote wakeup, not what should wake it up. A device
that wakes only if a button is clicked is within spec.

	Regards
		Oliver
