Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264023AbTGFWjN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 18:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266747AbTGFWjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 18:39:13 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:36517 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S264023AbTGFWjM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 18:39:12 -0400
Date: Mon, 7 Jul 2003 00:53:25 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: Joshua Kwan <joshk@triplehelix.org>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: orinoco USB driver
Message-ID: <20030706225325.GA16186@ranty.pantax.net>
Reply-To: ranty@debian.org
References: <20030706001601.GA8592@triplehelix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030706001601.GA8592@triplehelix.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 05, 2003 at 05:16:01PM -0700, Joshua Kwan wrote:
> I'm currently trying to get my Avaya Wireless 'Silver' USB device to
> work with the orinoco_usb driver v0.2.1.
> 
> Firstly, it is not 'supported.' So I had to use force_unsupported=1.
> But the firmware you download is from Avaya's site, so it seems to me
> like it should work!
> 
> Here's what i get:
> 
> firesong:/usr/src/orinoco-usb-0.2.1# modprobe orinoco_usb debug=1 force_unsupported=1
> /usr/src/orinoco-usb-0.2.1/driver/orinoco_usb.c: Device is not supported (you may want to set force_unsupported=1)
> /usr/src/orinoco-usb-0.2.1/driver/orinoco_usb.c: Trying to handle device anyway as requested
> /usr/src/orinoco-usb-0.2.1/driver/orinoco_usb.c:bridge_probe: ENTER
> /usr/src/orinoco-usb-0.2.1/driver/orinoco_usb.c: No firmware to download
> /usr/src/orinoco-usb-0.2.1/driver/orinoco_usb.c:bridge_remove_in_urb: no urb to remove
> /usr/src/orinoco-usb-0.2.1/driver/orinoco_usb.c:bridge_delete: ENTER
> unregister_netdevice: device wlan%d/cf4f3000 never was registered
> /usr/src/orinoco-usb-0.2.1/driver/orinoco_usb.c:bridge_delete: EXIT
> /usr/src/orinoco-usb-0.2.1/driver/orinoco_usb.c:bridge_probe: EXIT
> drivers/usb/core/usb.c: registered new driver Orinoco USB
> orinoco_usb.c v0.2.1 (Manuel Estrada Sainz <ranty@debian.org>)
> 
> The light does not come on and I don't get any device. I notice that the
> firmware is loaded from a .SYS file and installed into the hotplug
> /usr/lib directory. When is this loaded?
> 
> Do you have any pointers? It would be really nice to get the card to
> work!

 You need a working hotplug package for the new driver to work.

	Manuel


-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.
