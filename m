Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131337AbRBBAJo>; Thu, 1 Feb 2001 19:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131950AbRBBAJZ>; Thu, 1 Feb 2001 19:09:25 -0500
Received: from smtp8.xs4all.nl ([194.109.127.134]:31687 "EHLO smtp8.xs4all.nl")
	by vger.kernel.org with ESMTP id <S131376AbRBBAJX>;
	Thu, 1 Feb 2001 19:09:23 -0500
Date: Thu, 1 Feb 2001 23:16:52 +0000
From: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: hard crashes 2.4.0/1 with NE2K stuff
Message-ID: <20010201231652.A2684@grobbebol.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-OS: Linux grobbebol 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.1. rebuilt here and with a floodping towards my machine causes a
hard crash where nothing works anymore.

just before it happens :

Feb  1 13:07:24 grobbebol kernel: NETDEV WATCHDOG: eth0: transmit timed out
Feb  1 13:07:24 grobbebol kernel: eth0: Tx timed out, lost interrupt?  TSR=0x3, ISR=0x3, t=21.
Feb  1 13:07:36 grobbebol kernel: NETDEV WATCHDOG: eth0: transmit timed out
Feb  1 13:07:36 grobbebol kernel: eth0: Tx timed out, lost interrupt?  TSR=0x3, ISR=0xb7, t=38.
Feb  1 13:07:41 grobbebol kernel: NETDEV WATCHDOG: eth0: transmit timed out
Feb  1 13:07:41 grobbebol kernel: eth0: Tx timed out, lost interrupt?  TSR=0x3, ISR=0xb7, t=38.
Feb  1 13:07:43 grobbebol kernel: NETDEV WATCHDOG: eth0: transmit timed out
Feb  1 13:07:43 grobbebol kernel: eth0: Tx timed out, lost interrupt?  TSR=0x3, ISR=0x97, t=118.
Feb  1 13:07:45 grobbebol kernel: NETDEV WATCHDOG: eth0: transmit timed out
Feb  1 13:07:45 grobbebol kernel: eth0: Tx timed out, lost interrupt?  TSR=0x3, ISR=0x97, t=118.
Feb  1 13:07:46 grobbebol kernel: NETDEV WATCHDOG: eth0: transmit timed out
Feb  1 13:07:46 grobbebol kernel: eth0: Tx timed out, lost interrupt?  TSR=0x3, ISR=0x97, t=38.


note that it doesn't happen when 2.2.19pre* is used. Still some work
there to do.

the used board BP6 (abit), apics enabled. non-overclocked. card is a

00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8029(AS)

IRQ:

 19:       6851       7642   IO-APIC-level  eth0

I assume Franks suggestions didn't get into the kernel ?
-- 
Grobbebol's Home                   |  Don't give in to spammers.   -o)
http://www.xs4all.nl/~bengel       | Use your real e-mail address   /\
Linux 2.2.16 SMP 2x466MHz / 256 MB |        on Usenet.             _\_v  
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
