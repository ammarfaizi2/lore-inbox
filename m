Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271557AbRHZWbm>; Sun, 26 Aug 2001 18:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271560AbRHZWbc>; Sun, 26 Aug 2001 18:31:32 -0400
Received: from grobbebol.xs4all.nl ([194.109.248.218]:58462 "EHLO
	grobbebol.xs4all.nl") by vger.kernel.org with ESMTP
	id <S271557AbRHZWbP>; Sun, 26 Aug 2001 18:31:15 -0400
Date: Sun, 26 Aug 2001 22:29:57 +0000
From: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.4.9 && ETH0 stalls (8029)
Message-ID: <20010826222957.A711@grobbebol.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
X-OS: Linux grobbebol 2.4.7 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have osted this before but haven't seen it on the list. Sometimes, it
seems to fail at vger for whatever reason. sorry if this was double.

2.4.9. again shows tieouts onETH0 with the 8029 realtek stuff. 2.4.8 and
2.4.7 work fine here.

messages:Aug 24 21:26:53 grobbebol kernel: NETDEV WATCHDOG: eth0: transmit timed out
messages:Aug 24 21:26:53 grobbebol kernel: eth0: Tx timed out, lost interrupt? TSR=0x3, ISR=0x3, t=116.
messages:Aug 24 21:27:01 grobbebol kernel: NETDEV WATCHDOG: eth0: transmit timed out
messages:Aug 24 21:27:01 grobbebol kernel: eth0: Tx timed out, lost interrupt? TSR=0x3, ISR=0x3, t=756.
messages:Aug 24 21:27:03 grobbebol kernel: NETDEV WATCHDOG: eth0: transmit timed out
messages:Aug 24 21:27:03 grobbebol kernel: eth0: Tx timed out, lost interrupt? TSR=0x3, ISR=0x3, t=119.
messages:Aug 24 21:27:06 grobbebol kernel: NETDEV WATCHDOG: eth0: transmit timed out
messages:Aug 24 21:27:06 grobbebol kernel: eth0: Tx timed out, lost interrupt? TSR=0x3, ISR=0x3, t=119.
messages:Aug 24 21:27:09 grobbebol kernel: NETDEV WATCHDOG: eth0: transmit timed out
messages:Aug 24 21:27:09 grobbebol kernel: eth0: Tx timed out, lost interrupt? TSR=0x3, ISR=0x3, t=219.
messages:Aug 24 21:27:11 grobbebol kernel: NETDEV WATCHDOG: eth0: transmit timed out
messages:Aug 24 21:27:11 grobbebol kernel: eth0: Tx timed out, lost interrupt? TSR=0x3, ISR=0x3, t=119.
messages:Aug 24 21:27:23 grobbebol kernel: NETDEV WATCHDOG: eth0: transmit timed out
messages:Aug 24 21:27:23 grobbebol kernel: eth0: Tx timed out, lost interrupt? TSR=0x3, ISR=0x3, t=116.

etc. and a reboiot is required. 2.4.9 never survives more than between
12 and 24 hours before it 'kills' the eth0.

00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8029(AS)

(hopefully this article gets posted now :-)

-- 
Grobbebol's Home                   |  Don't give in to spammers.   -o)
http://www.xs4all.nl/~bengel       | Use your real e-mail address   /\
Linux 2.2.16 SMP 2x466MHz / 256 MB |        on Usenet.             _\_v  
