Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262619AbRFGNp2>; Thu, 7 Jun 2001 09:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262617AbRFGNpS>; Thu, 7 Jun 2001 09:45:18 -0400
Received: from [195.184.98.160] ([195.184.98.160]:39941 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262615AbRFGNpI>;
	Thu, 7 Jun 2001 09:45:08 -0400
Date: Thu, 7 Jun 2001 14:41:44 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [patch] 4GB I/O, cut 5
Message-ID: <20010607144144.A1522@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes:

- merge 2.4.6-pre1 zone changes for zone-dma32-6
- correct qlogicfc can_dma_32 flag (Arjan van de Ven)

Arjan also reported that the kernel doesn't boot on a machine with 8GB
of RAM, I'm suspecting the zone-dma32-6 changes. If someone has access
to such a machine, please try it.

There are no bug fixes in this release either - apart from the above
problem, no known bugs exists. I'll be donating a virtual beer for the
first spotted bug.

The patch can be considered stable, it's received quite a bit of testing
on highend hardware. Here's a plug from one such tester:

"Regarding performance of this patch, it is providing us with the highest
aggregate throughput for reads of any of the recent kernels for multiple
IOs - up to 185MB/s continuous through both controllers :)"

*.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.6-pre1/

-- 
Jens Axboe

