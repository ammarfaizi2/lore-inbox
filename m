Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbTFTA0z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 20:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262032AbTFTA0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 20:26:55 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:8930 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262018AbTFTA0w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 20:26:52 -0400
Date: Thu, 19 Jun 2003 17:40:35 -0700
From: Greg KH <greg@kroah.com>
To: Linux-usb-users@lists.sourceforge.net,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] USB updates for 2.4.21
Message-ID: <20030620004035.GA7817@kroah.com>
Reply-To: linux-usb-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've rolled up all of the pending patches that I've been storing up for
2.4.21 into one big patch and placed it on kernel.org at:

  kernel.org/pub/linux/kernel/people/gregkh/usb/2.4/usb-2.4.21.patch.gz

This includes all of the patches that I sent to Marcelo yesterday, and 2
more (one more usb-storage unusual_dev entry, and another ehci update).
I strongly recommend this patch for anyone who wants to use USB 2.0
devices on 2.4.21.

I've included a list of all of the changes included in here below.

Hope this can be useful to some people.

thanks,

greg k-h


--------
<cweidema:indiana.edu>:
  o USB: pentax optio S

<hanno:gmx.de>:
  o USB: Patch for Vivicam 355

<richard.curnow:superh.com>:
  o USB: ehci-hcd.c needs to include <linux/bitops.h>

Alan Stern:
  o USB: US_SC_DEVICE and US_PR_DEVICE for 2.4

Ben Collins:
  o USB: Actually Fix 2.4 HID input
  o USB: fix keyboard leds
  o USB Multi-input quirk
  o USB: Happ UGCI added as BADPAD for workaround

Bryan W. Headley:
  o USB: Aiptek kernel driver 1.0 for Kernel 2.4

Christopher L. Cheney:
  o USB: vicam.c copyright patches

David Brownell:
  o USB: EHCI update for 2.4
  o USB: SMP ehci-q.c 1010 BUG()
  o USB: ehci i/o watchdog

David T. Hollis:
  o USB: AX8817X Driver for 2.4 Kernels

Duncan Sands:
  o USB speedtouch: parametrize the module
  o USB speedtouch: set owner fields
  o USB speedtouch: remove MOD_XXX_USE_COUNT
  o USB speedtouch: receive code rewrite
  o USB speedtouch: receive path micro optimization
  o USB speedtouch: remove useless NULL pointer checks
  o USB speedtouch: kfree_skb -> dev_kfree_skb
  o USB speedtouch: send path micro optimizations
  o USB speedtouch: use optimally sized reconstruction buffers
  o USB speedtouch: verbose debugging
  o USB speedtouch: spin_lock_irqsave -> spin_lock_irq in tasklets
  o USB speedtouch: spin_lock_irqsave -> spin_lock_irq in process context
  o USB speedtouch: add defensive memory barriers
  o USB speedtouch: replace yield()
  o USB speedtouch: add missing #include
  o USB speedtouch: trivial whitespace and name changes
  o USB speedtouch: remove trailing semicolon
  o USB speedtouch: compile fix
  o USB speedtouch: crc optimization
  o USB speedtouch: bump the version number
  o USB speedtouch: discard packets for non-existant vcc's
  o USB speedtouch: move MOD_INC_USE_COUNT
  o USB: Backport of USB speedtouch driver to 2.4

Geert Uytterhoeven:
  o USB: Big endian RTL8150

Greg Kroah-Hartman:
  o USB: clean up extra whitespace in visor.c driver
  o USB: fixup aiptek driver for older compilers
  o USB: add error reporting functionality to the pl2303 driver
  o USB: pegasus ethtool fixup
  o USB: fix break control for pl2303 driver
  o USB: add comment to storage/unusual_devs.h that specifies how to add new entries
  o USB: attempt to track down pl2303 oopses on close
  o USB: added support for Sony DSC-P8

Hartmut Wahl:
  o USB:  Patch for Samsung Digimax 410

Henning Meier-Geinitz:
  o USB: New vendor/product ids for scanner driver

James Courtier-Dutton:
  o USB: Add support for Pentax Still Camera to linux kernel

Johannes Erdfelt:
  o USB: fix 2.4 usbdevfs race

Lars Gemeinhardt:
  o USB: add support for Mello MP3 Player

Nicolas Dupeux:
  o USB: UNUSUAL_DEV for aiptek pocketcam

Olaf Hering:
  o USB: incorrect ethtool -i driver name
  o USB: incorrect ethtool -i driver name

Paul Stewart:
  o USB: HIDDev uref backport for 2.4?

Per Winkvist:
  o Re: unusual_devs.h patch that was in 2.5.68
  o USB: more unusual_devs.h changes

Petko Manolov:
  o USB: pegasus patch

Philipp Friedrich:
  o USB: unusual_devs.h patch

Sergey Vlasov:
  o USB: HIDDEV / UPS patches

Stefan M. Brandl:
  o USB: another usb storage addition

Thomas Wahrenbruch:
  o USB: kobil_sct.c added support for KAAN SIM Reader

Vojtech Pavlik:
  o USB: Fix HID logical min/max for 2.4
  o USB: Make Olympus cameras work with usb-storage

Walter Harms:
  o USB: fixes kernel_thread
  o USB: fixes kernel_thread

