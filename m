Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261577AbVALXmg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261577AbVALXmg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 18:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbVALXmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 18:42:24 -0500
Received: from jive.SoftHome.net ([66.54.152.27]:53483 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S261577AbVALXjF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 18:39:05 -0500
Subject: PCI lost interrupts and PLX chips
From: Dimitris Lampridis <soth@softhome.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Message-Id: <1105573129.3218.11.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 13 Jan 2005 01:38:49 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,
I noticed a conversation some days ago that also mentioned something
about PLX chips and a certain problem resulting in loss of interrupt
signals.

I'm writing a driver for a PCI-based device (an embedded USB Host
Controller) and it uses a PLX bridge (device ID 5406). Although I've set
up the device correctly and a logical analyzer shows the interrupts
being generated on the USB HC chip, nothing comes past the bridge, thus
nothing reaches the system. I use a typical pci_enable_device() followed
but some request_region() and of course request_irq() on a kernel
2.6.10-rc3 (i386 system, VIA KT133, no APIC...)
Does this have something to do with the discussion about PLX chips
mentioned above? If it does, can anybody make clear what I have to do to
see those interrupts coming?

You can find the mail in question at:
http://seclists.org/lists/linux-kernel/2005/Jan/0792.html

Thanks,
Dimitris

