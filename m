Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318284AbSICOOW>; Tue, 3 Sep 2002 10:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318327AbSICOOW>; Tue, 3 Sep 2002 10:14:22 -0400
Received: from relay.muni.cz ([147.251.4.35]:59592 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id <S318284AbSICOOV>;
	Tue, 3 Sep 2002 10:14:21 -0400
Date: Tue, 3 Sep 2002 16:18:46 +0200
From: Jan Kasprzak <kas@informatics.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: RAID5 checksum algorithm selection
Message-ID: <20020903161846.J18187@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello, world!\n

	I've tested RAID-5 on my new dual athlon box, and got the
following messages during system boot:

raid5: measuring checksumming speed
   8regs     :  2550.400 MB/sec
   32regs    :  1702.000 MB/sec
   pIII_sse  :  4735.600 MB/sec
   pII_mmx   :  3910.800 MB/sec
   p5_mmx    :  5016.800 MB/sec
raid5: using function: pIII_sse (4735.600 MB/sec)

	Why does the kernel decide to use the pIII_sse function,
even though the p5_mmx is faster?

	The kernel is 2.4.20-pre5-ac1.

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
       Pruning my incoming mailbox after being 10 days off-line,
       sorry for the delayed reply.
