Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264097AbTFYIGq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 04:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264151AbTFYIGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 04:06:46 -0400
Received: from abicko.abclinuxu.cz ([80.95.102.12]:52617 "HELO
	abicko.abclinuxu.cz") by vger.kernel.org with SMTP id S264097AbTFYIGp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 04:06:45 -0400
Date: Wed, 25 Jun 2003 10:20:53 +0200 (CEST)
From: Semler Michal <cijoml@abclinuxu.cz>
To: linux-kernel@vger.kernel.org
Subject: hda: dma_timer_expiry: dma status == 0x24
Message-ID: <Pine.LNX.4.44.0306251015520.6524-100000@ABicko.abclinuxu.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
after running 2.4.21 I getts into dmesg one time per day
this message:

hda: dma_timer_expiry: dma status == 0x24
hda: lost interrupt
hda: dma_intr: bad DMA status (dma_stat=30)
hda: dma_intr: status=0x50 { DriveReady SeekComplete }

this never  did before. I tried revert to 2.4.20
and it's clean?

hda: ST360021A, ATA DISK drive
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=116301/16/63,
UDMA(100)

Partition check:
 hda: hda1 hda2 hda3


Thanks
CIJOML

