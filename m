Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263893AbTLARTt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 12:19:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263891AbTLARTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 12:19:49 -0500
Received: from havoc.gtf.org ([63.247.75.124]:231 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S263890AbTLARTr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 12:19:47 -0500
Date: Mon, 1 Dec 2003 12:15:27 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] libata (Serial ATA) update
Message-ID: <20031201171527.GA23280@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Some more bug fixes:
* Use sg_dma_xxx macros.  Fixes "doesn't build" on some non-x86
  platforms, and fixes "doesn't work" on some other non-x86 platforms.
* Fix for Promise SX4

Patch for 2.4.23:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.4.23-libata1.patch.bz2

Patch for 2.6.0-test11:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.0-test11-libata1.patch.bz2

BK users:
http://gkernel.bkbits.net/libata-2.[45]


