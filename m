Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270469AbRHWV0R>; Thu, 23 Aug 2001 17:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270480AbRHWV0H>; Thu, 23 Aug 2001 17:26:07 -0400
Received: from pizda.ninka.net ([216.101.162.242]:19083 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S270469AbRHWVZx>;
	Thu, 23 Aug 2001 17:25:53 -0400
Date: Thu, 23 Aug 2001 14:26:06 -0700 (PDT)
Message-Id: <20010823.142606.48398643.davem@redhat.com>
To: linux-kernel@vger.kernel.org
CC: axboe@suse.de
Subject: [UPDATE] pci64 updates
From: "David S. Miller" <davem@redhat.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Version 3 of the 2.4.9 PCI64 dma API patches are up,
just a few bug fixes this time, nothing major:

ftp://ftp.kernel.org/pub/linux/kernel/people/davem/PCI64/pci64-2.4.9-3.patch.gz

Changes:

1) Fix two typos in DMA-mapping.txt, from Jens.
2) Gerard points out a bug in sym53c8xx changes, only
   chip variants supporting DAC should attempt to use
   40-bit DAC configuration in PCI layer.

Later,
David S. Miller
davem@redhat.com
