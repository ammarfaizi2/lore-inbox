Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261913AbUBWLFw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 06:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261915AbUBWLFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 06:05:52 -0500
Received: from ux1.ibb.net ([64.215.98.2]:10761 "EHLO ux1.ibb.net")
	by vger.kernel.org with ESMTP id S261913AbUBWLFu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 06:05:50 -0500
Date: Mon, 23 Feb 2004 10:59:53 +0100 (MET)
From: Mipam <mipam@ibb.net>
To: <linux-kernel@vger.kernel.org>
cc: <mipam@ibb.net>
Subject: broadcom bcm5703 support in 2.6.3?
Message-ID: <Pine.LNX.4.33.0402231043430.30027-100000@ux1.ibb.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've got an luser question. :-)
While running 2.4 i was able to use the following broadcom cards just
fine:

Broadcom Gigabit Ethernet Driver bcm5700 with Broadcom NIC
Extension
(NICE) ver.
 6.0.5 (04/14/03)
eth0: Broadcom BCM5703 1000Base-T found at mem fcf10000, IRQ 28, node addr
000bd
be76f62
eth0: Broadcom BCM5703 Integrated Copper transceiver found
eth0: Scatter-gather ON, 64-bit DMA ON, Tx Checksum ON, Rx Checksum ON
eth1: Broadcom BCM5703 1000Base-T found at mem fcf00000, IRQ 29, node addr
000bd
be76f63
eth1: Broadcom BCM5703 Integrated Copper transceiver found
eth1: Scatter-gather ON, 64-bit DMA ON, Tx Checksum ON, Rx Checksum ON
bcm5700: eth0 NIC Link is UP, 100 Mbps full duplex
bcm5700: eth1 NIC Link is UP, 100 Mbps full duplex

Now i build a 2.6.3 kernel and im looking where there is support for these
cards. In menuconfig i went to:

Device Drivers -> Networking Support -> Ethernet 1000mbit

And in here i only see broadcom tigon3 support
And in Ethernet 10-100Mbit i only see:

Broadcom 4400 ethernet support

No where appears to be bcm5703 support.
Where should i be in the config of the kernel to enable bcm5703 support?
Thanks,

Mipam.

