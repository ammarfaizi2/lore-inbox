Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261865AbVATSfB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbVATSfB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 13:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261774AbVATSa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 13:30:28 -0500
Received: from pop-a065d19.pas.sa.earthlink.net ([207.217.121.253]:50850 "EHLO
	pop-a065d19.pas.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S261731AbVATS3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 13:29:49 -0500
From: John Mock <kd6pag@qsl.net>
To: David Woodhouse <dwmw2@infradead.org>
cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: re: 2.6.11-rc1 vs. PowerMac 8500/G3 (and VAIO laptop) [usb-storage oops]
Message-Id: <E1Crh3W-0001KD-00@penngrove.fdns.net>
Date: Thu, 20 Jan 2005 10:29:18 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is that really new to 2.6.11-rc1? The kernel byte-swaps the bcdUSB,
> idVendor, idProduct, and bcdDevice fields in the device descriptor. It
> should probably swap them back before copying it up to userspace.

Yes, it happens with 2.6.11-rc1 on my PowerPC, but not with 2.6.10 (or
before), or on my Sony VAIO laptop. However, it does not prevent it from
recognizing devices and/or having 'hotplug' load the appropriate module.

Alas, when it does load 'usb-storage', it generally gets an oops, as
previously described, which seems to prevent the use of that device.

Not being able to use USB devices on the PPC (nor fireware on the VAIO
laptop after suspending) cause grief for me; 'lsusb' is just a minor
annoyance by comparison.

PLEASE let me know if there's anything i can do to help track this down!

			         -- JM
