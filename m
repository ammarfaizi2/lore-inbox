Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262473AbUCRJq4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 04:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262479AbUCRJq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 04:46:56 -0500
Received: from aun.it.uu.se ([130.238.12.36]:55199 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262473AbUCRJol (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 04:44:41 -0500
From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16473.28514.341276.209224@alkaid.it.uu.se>
Date: Thu, 18 Mar 2004 10:44:02 +0100
To: Jeff Garzik <jgarzik@pobox.com>
Subject: tulip (pnic) errors in 2.6.5-rc1
CC: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.5-rc1 causes my Netgear FA310TX to
fill the kernel log with messages like:

eth1: In tulip_rx(), entry 57 004c0728.
eth1: interrupt  csr5=0x02670050 new csr5=0x02660010.
eth1: exiting interrupt, csr5=0x2660010.
 In tulip_rx(), entry 58 004c0728.
eth1: In tulip_rx(), entry 58 004c0728.
eth1: interrupt  csr5=0x02670050 new csr5=0x02660010.
eth1: exiting interrupt, csr5=0x2660010.
 In tulip_rx(), entry 59 006a0300.
eth1: In tulip_rx(), entry 59 006a0300.
eth1: interrupt  csr5=0x02670050 new csr5=0x02660010.
eth1: exiting interrupt, csr5=0x2660010.
eth1: interrupt  csr5=0x02670014 new csr5=0x02660010.
eth1: exiting interrupt, csr5=0x2660010.

and on and on and on ...

No previous kernel had this problem.

2.6.4 identifies the nic as:

PCI: Found IRQ 10 for device 0000:00:0b.0
tulip1:  MII transceiver #1 config 3000 status 7829 advertising 01e1.
eth1: Lite-On 82c168 PNIC rev 32 at 0xa000, XX:XX:XX:XX:XX:XX, IRQ 10.
eth1: Setting full-duplex based on MII#1 link partner capability of 41e1.

/Mikael
