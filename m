Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135920AbRDZU7H>; Thu, 26 Apr 2001 16:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135926AbRDZU6l>; Thu, 26 Apr 2001 16:58:41 -0400
Received: from zeus.kernel.org ([209.10.41.242]:128 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S135919AbRDZU6N>;
	Thu, 26 Apr 2001 16:58:13 -0400
Date: Thu, 26 Apr 2001 13:18:46 -0700
From: Mike Panetta <mpanetta@applianceware.com>
To: linux-kernel@vger.kernel.org
Subject: HPT366 IDE DMA error question.
Message-ID: <20010426131846.A29148@tetsuo.applianceware.com>
Mail-Followup-To: Mike Panetta <mpanetta@applianceware.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: ApplianceWare
X-Mailer: mutt (ruff!  ruff!)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


What could cause this error?

hdi: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hdi: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
hdi: DMA disabled
ide4: reset: success

I get this message on all my off board HPT366 based controller
cards.  I am using these cards with seagate Barracuda ATA III
Model ST320414A 20GB drives.  Are there any known issues with 
these drives and the HPT366 based controllers?  Are there any
known issues with using 2-3 HPT366 cards in one system?  There
is only 1 drive per channel (2 per card).  I am using this setup
with Software RAID and needless to say no DMA=slow as hell.
Just so you know the onboard IDE controller works fine.  The
drives report no errors on the onboard controllers and they
have UDMA enabled (it was not disabled by the kernel).

If there is any other info that is needed I will be glad
to provide it.

Thanks,
Mike
-- 
