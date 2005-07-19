Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbVGST3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbVGST3c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 15:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261481AbVGST3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 15:29:32 -0400
Received: from mail.kroah.org ([69.55.234.183]:41138 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261228AbVGST3b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 15:29:31 -0400
Date: Tue, 19 Jul 2005 15:29:18 -0400
From: Greg KH <greg@kroah.com>
To: Karim Yaghmour <karim@opersys.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Weird USB errors on HD
Message-ID: <20050719192918.GA19803@kroah.com>
References: <42DD2EA4.5040507@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42DD2EA4.5040507@opersys.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2005 at 12:47:32PM -0400, Karim Yaghmour wrote:
> 
> I have a usb-attached HD that I use from time to time. When it's connected
> to my desktop through a hub it works flawlessly. When connected to my Dell
> D600 Laptop, however, it sometimes randomly exhibits a loud click (as if the
> heads went berzerk) and the device goes unrecognized (i.e. the USB layer drops
> the device and then redetects it again; meanwhile there is FS corruption.)
> 
> The same behavior happens with 2.4.x and 2.6.x
> 
> In /var/log/messages I see something like:
> hub 3-0:1.0: over-current change on port 1
> hub 1-0:1.0: over-current change on port 3
> ...
> usb 1-3: USB disconnect, address 2
> usb 1-3: new high speed USB device using ehci_hcd and address 3

Ugh, you have a bad device or power supply, or aren't giving it enough
power to drive the thing.  Nothing we can do in Linux for that, sorry.
Buy a wall-powered usb hub, that usually helps.

Good luck,

greg k-h
