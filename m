Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262443AbUCWKeQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 05:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262454AbUCWKeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 05:34:15 -0500
Received: from stilton.pencil.net ([217.204.76.170]:30681 "EHLO
	stilton.pencil.net") by vger.kernel.org with ESMTP id S262443AbUCWKcq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 05:32:46 -0500
Date: Tue, 23 Mar 2004 10:32:45 +0000
From: Doug Winter <doug@pigeonhold.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: APIC on Chaintech ZNF3-150 Motherboard
Message-ID: <20040323103245.GB24221@pigeonhold.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, doug@pigeonhold.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Reported to Ingo Molnar who told me to send it here too.)

I've just put a new computer together with an AMD Athlon 64 3200+ and a
Chaintech ZNF3-150 motherboard.  This has the Nvidia NForce 3 chipset.

Booting 2.6.4, from the debian kernel-image-2.6.4-1-k7 package, I get
reproducible errors from the onboard BCM5788 NIC and a Realtek 8139 NIC
when under load.

When the disk is under load, I get reproducible DMA errors from any IDE
disk that is under load.

When I boot with "noapic", these problems go away.

I'm happy to help debug this any way necessary.

Thanks,

Doug.

(Please CC: me, I am not subscribed)

-- 
   http://adju.st   | It's nice to be important but
6973E2CF: 2C95 66AD | more important to be nice
1596 37D2 41FC 609F |         -- Scooter
76C0 A4EC 6973 E2CF |
