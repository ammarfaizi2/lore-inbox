Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263397AbRFAPSq>; Fri, 1 Jun 2001 11:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263557AbRFAPS0>; Fri, 1 Jun 2001 11:18:26 -0400
Received: from grobbebol.xs4all.nl ([194.109.248.218]:37187 "EHLO
	grobbebol.xs4all.nl") by vger.kernel.org with ESMTP
	id <S263397AbRFAPSR>; Fri, 1 Jun 2001 11:18:17 -0400
Date: Fri, 1 Jun 2001 15:17:05 +0000
From: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: ethernet still quits
Message-ID: <20010601151705.A526@grobbebol.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
X-OS: Linux grobbebol 2.4.5 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.5 :

when quote some xfers have taken place, the realtek card dies here.

Jun  1 14:58:12 grobbebol kernel: NETDEV WATCHDOG: eth0: transmit timed out
Jun  1 14:58:12 grobbebol kernel: eth0: Tx timed out, lost interrupt?  TSR=0x3, ISR=0x3, t=1303.
Jun  1 14:58:14 grobbebol kernel: NETDEV WATCHDOG: eth0: transmit timed out
Jun  1 14:58:14 grobbebol kernel: eth0: Tx timed out, lost interrupt?  TSR=0x3, ISR=0x3, t=103.
Jun  1 14:58:28 grobbebol kernel: NETDEV WATCHDOG: eth0: transmit timed out
Jun  1 14:58:28 grobbebol kernel: eth0: Tx timed out, lost interrupt?  TSR=0x3, ISR=0x3, t=103.
Jun  1 14:58:30 grobbebol kernel: NETDEV WATCHDOG: eth0: transmit timed out
Jun  1 14:58:30 grobbebol kernel: eth0: Tx timed out, lost interrupt?  TSR=0x3, ISR=0x3, t=123.
Jun  1 14:58:32 grobbebol kernel: NETDEV WATCHDOG: eth0: transmit timed out
Jun  1 14:58:32 grobbebol kernel: eth0: Tx timed out, lost interrupt?  TSR=0x3, ISR=0x3, t=103.

etc. only rebooting helps.

hardware BP6, non OC, happens with older kernels as well sometimes.


-- 
Grobbebol's Home                   |  Don't give in to spammers.   -o)
http://www.xs4all.nl/~bengel       | Use your real e-mail address   /\
Linux 2.2.16 SMP 2x466MHz / 256 MB |        on Usenet.             _\_v  
