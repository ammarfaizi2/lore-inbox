Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129882AbQKGWWN>; Tue, 7 Nov 2000 17:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129884AbQKGWWE>; Tue, 7 Nov 2000 17:22:04 -0500
Received: from c837140-a.vncvr1.wa.home.com ([65.0.81.146]:62724 "EHLO
	cyclonehq.dnsalias.net") by vger.kernel.org with ESMTP
	id <S129524AbQKGWVm>; Tue, 7 Nov 2000 17:21:42 -0500
Date: Tue, 7 Nov 2000 14:20:44 -0800 (PST)
From: Dan Browning <danb@cyclonehq.dnsalias.net>
To: Andre Hedrick <andre@linux-ide.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [HARDLOCK] 2.2.17 locks up hard on Ultra66/PDC20262 in DMA mode
 when using ide + raid-A0 + eepro100 patches
In-Reply-To: <Pine.LNX.4.10.10011061938520.18160-200000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.21.0011071405390.11597-100000@cyclonehq.dnsalias.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

UPDATE:

Thanks to Andre's 2.2.18pre19 patch, we're making progress!  This time I
had 4 hrs 10 min uptime before it locked up.

And this time, it only said 

hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x10 { SectorIdNotFound }, LBAsect=15347359,
sector=15347328

once, instead of repeating that error 4 times.  

What should I try now?  Maybe I'll give 2.4.0-test10 another shot, but
last time I tried it, it corrupted my raid5 array.

What next...

On Mon, 6 Nov 2000, Andre Hedrick wrote:
> 
> Fsn shake this at it...
> 
> 
> Andre Hedrick
> CTO Timpanogas Research Group
> EVP Linux Development, TRG
> Linux ATA Development
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
