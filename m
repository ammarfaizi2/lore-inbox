Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265896AbUAEIM0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 03:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265898AbUAEIM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 03:12:26 -0500
Received: from mail.kroah.org ([65.200.24.183]:62640 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265896AbUAEIMY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 03:12:24 -0500
Date: Mon, 5 Jan 2004 00:12:26 -0800
From: Greg KH <greg@kroah.com>
To: lk@rekl.yi.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: KM266/VT8235, USB2.0 and problems
Message-ID: <20040105081226.GA14177@kroah.com>
References: <Pine.LNX.4.58.0401042314160.18200@rekl.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401042314160.18200@rekl.yi.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 04, 2004 at 11:30:51PM -0600, lk@rekl.yi.org wrote:
> Hi.  I've noticed that intermittently in the past with some devices, and 
> now every time with my new USB2.0 thumb drive (aka pen drive, aka flash 
> memory thing) that there are errors with the USB on my motherboard.  It's 
> a M7VIG-PRO, which has a KM266/VT8235 chipset.
> 
> Using kernel 2.6.0, I can only access my flash drive several times before 
> getting an error about not being able to access the device.  The dmesg 
> output is below.  When I try on my laptop, which has an EHCI USB2.0 
> controller, the device works flawlessly.  There are no errors, etc.
> 
> I am using a USB keyboard and a USB mouse.  Both work fine.
> 
> I've tried several combinations of connecting the device, with and without 
> the "noapic" kernel option while booting.  I've connected the device to 
> the motherboard's USB sockets (ie the ones soldered to the board, not via 
> wires to the case), through a USB2.0 hub, etc.  I get the same result 
> every time.
> 
> I've included the relevant parts of "dmesg" and "dmidecode".  Please cc: 
> me on responses, since I'm not subscribed, and let me know what to try 
> next.

Do the errors go away if you stop using devfs?

thanks,

greg k-h
