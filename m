Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbVJaUle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbVJaUle (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 15:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbVJaUle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 15:41:34 -0500
Received: from seahorse.mweb.co.za ([196.2.45.85]:45712 "EHLO
	seahorse.mweb.co.za") by vger.kernel.org with ESMTP id S964827AbVJaUle
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 15:41:34 -0500
From: Bongani Hlope <bonganilinux@mweb.co.za>
To: linux-kernel@vger.kernel.org, axboe@suse.de, piggin@cyberone.com.au
Subject: Badness in as_insert_request at drivers/block/as-iosched.c:1519
Date: Mon, 31 Oct 2005 22:40:48 +0200
User-Agent: KMail/1.8.92
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510312240.49228.bonganilinux@mweb.co.za>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

When I rip a music CD I get these for each track that is ripped. 


 Badness in as_insert_request at drivers/block/as-iosched.c:1519

 Call Trace:<ffffffff80281b0f>{as_insert_request+111} 
<ffffffff80278689>{__elv_add_request+105}
<ffffffff802787a8>{elv_add_request+72} 
<ffffffff8027b9f6>{blk_execute_rq_nowait+54}
<ffffffff8027bac8>{blk_execute_rq+184} 
<ffffffff80184ee7>{bio_phys_segments+23}
<ffffffff8027b67b>{blk_rq_bio_prep+59} 
<ffffffff8817226b>{:cdrom:mmc_ioctl+1275}
<ffffffff8817c51e>{:ide_cd:cdrom_queue_packet_command+78}
<ffffffff8028d838>{ide_init_drive_cmd+24} 
<ffffffff8817d47f>{:ide_cd:cdrom_check_status+127}
<ffffffff8015eae0>{__rmqueue+192} <ffffffff8015f200>{buffered_rmqueue+544}
<ffffffff8028050d>{scsi_cmd_ioctl+1997} <ffffffff80341841>{thread_return+193}
<ffffffff8010c552>{__switch_to+50} <ffffffff80341841>{thread_return+193}
<ffffffff80342f73>{_spin_unlock_irqrestore+19} 
<ffffffff8015e8f6>{free_pages_bulk+582}
<ffffffff88173e51>{:cdrom:cdrom_ioctl+2529} 
<ffffffff80166aa3>{release_pages+387}
<ffffffff8817ebb6>{:ide_cd:idecd_ioctl+102} 
<ffffffff8027dc88>{blkdev_driver_ioctl+104}
<ffffffff8027e40b>{blkdev_ioctl+1883} 
<ffffffff8016dc67>{__handle_mm_fault+407}
<ffffffff80342f73>{_spin_unlock_irqrestore+19} 
<ffffffff801fb261>{__up_read+161}
<ffffffff80344b9d>{do_page_fault+1213} <ffffffff80188b3b>{block_ioctl+27}
<ffffffff80193aee>{do_ioctl+62} <ffffffff80193e1b>{vfs_ioctl+715}
<ffffffff80193e8d>{sys_ioctl+77} <ffffffff8010dd5e>{system_call+126}
