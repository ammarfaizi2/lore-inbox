Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130815AbQKGDVM>; Mon, 6 Nov 2000 22:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130638AbQKGDVC>; Mon, 6 Nov 2000 22:21:02 -0500
Received: from c837140-a.vncvr1.wa.home.com ([65.0.81.146]:29444 "EHLO
	cyclonehq.dnsalias.net") by vger.kernel.org with ESMTP
	id <S130815AbQKGDUr>; Mon, 6 Nov 2000 22:20:47 -0500
Date: Mon, 6 Nov 2000 19:20:51 -0800 (PST)
From: Dan Browning <danb@cyclonehq.dnsalias.net>
To: Dan Browning <danb@cyclonecomputers.com>
cc: linux-kernel@vger.kernel.org, frankt@promise.com, andre@linux-ide.org,
        bkz@linux-ide.org
Subject: Re: [HARDLOCK] 2.2.17 locks up hard on Ultra66/PDC20262 in DMA mode
 when using ide + raid-A0 + eepro100 patches
In-Reply-To: <Pine.LNX.4.21.0011061403270.11315-100000@cyclonehq.dnsalias.net>
Message-ID: <Pine.LNX.4.21.0011061858580.11597-100000@cyclonehq.dnsalias.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

UPDATE:

Now I have upgraded to 2.2.18pre19 + ide-2.2.18pre18 + raid-2.2.18-A2 +
patched eepro100.

Unfortunately, I still get:

hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x10 { SectorIdNotFound }, LBAsect=15347359,
sector=15347328
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x10 { SectorIdNotFound }, LBAsect=15347359,
sector=15347328
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x10 { SectorIdNotFound }, LBAsect=15347359,
sector=15347328
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x10 { SectorIdNotFound }, LBAsect=15347359,
sector=15347328


after a few minutes/hours of uptime (60-180 minutes).  I even tried some
SysRq keys and those wouldn't work.  (hard lockup).  So what do I try from
here?  I d'nt think there is any way to disable DMA in the hardware (on
the Promise anyway).  Should I pull out hde and throw in another seagate?

thanks for any ideas.

-dan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
