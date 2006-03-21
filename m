Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751796AbWCUV4B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796AbWCUV4B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 16:56:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751782AbWCUV4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 16:56:00 -0500
Received: from havoc.gtf.org ([69.61.125.42]:2270 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751790AbWCUVz6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 16:55:58 -0500
Date: Tue, 21 Mar 2006 16:55:56 -0500
From: Jeff Garzik <jeff@garzik.org>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [git patches] net driver updates
Message-ID: <20060321215556.GA23047@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[just pushed upstream; patch too big to inline]

Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

to receive the following updates:

 Documentation/networking/e100.txt  |  158 -
 Documentation/networking/e1000.txt |  634 +++--
 MAINTAINERS                        |   16 
 drivers/net/mv643xx_eth.h          |   18 
 drivers/net/pcnet32.c              | 4161 +++++++++++++++++++------------------
 drivers/net/skfp/fplustm.c         |   12 
 drivers/net/skge.c                 |  275 +-
 drivers/net/skge.h                 |    1 
 drivers/net/sky2.c                 |  583 ++---
 drivers/net/sky2.h                 |   22 
 drivers/net/smc91x.c               |   53 
 drivers/net/smc91x.h               |  478 ++--
 12 files changed, 3467 insertions(+), 2944 deletions(-)

Andrew Morton:
      skfp warning fixes

Dale Farnsworth:
      mv643xx_eth: Cache align skb->data if CONFIG_NOT_COHERENT_CACHE

Don Fry:
      pcnet32: support boards with multiple phys

Jeff Garzik:
      [netdrvr] pcnet32: Lindent
      [netdrvr] pcnet32: other source formatting cleanups

Jesse Brandeburg:
      e100/e1000/ixgb: update MAINTAINERS to current developers
      e100: update e100.txt
      e1000: update the readme with the latest text

Nicolas Pitre:
      smc91x: allow for dynamic bus access configs

Stephen Hemminger:
      skge: use NAPI for tx cleanup.
      skge: use auto masking of irqs
      skge: check the allocation of ring buffer
      skge: dma configuration cleanup
      skge: use kcalloc
      skge: use mmiowb
      skge: formmating and whitespace cleanup
      skge: handle pci errors better
      skge: version 1.4
      sky2: remove support for untested Yukon EC/rev 0
      sky2: drop broken wake on lan support
      sky2: rework of NAPI and IRQ management
      sky2: coalescing parameters
      sky2: add MSI support
      sky2: whitespace fixes
      sky2: transmit recovery
      sky2: handle all error irqs
      sky2 version 1.1

