Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317504AbSHHMTd>; Thu, 8 Aug 2002 08:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317506AbSHHMTc>; Thu, 8 Aug 2002 08:19:32 -0400
Received: from mail-in1.inet.tele.dk ([194.182.148.158]:32096 "HELO
	mail-in1.inet.tele.dk") by vger.kernel.org with SMTP
	id <S317504AbSHHMTb>; Thu, 8 Aug 2002 08:19:31 -0400
Subject: forcing the tg3 into full duplex
From: Frederik Dannemare <tux@sentinel.dk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 08 Aug 2002 14:21:56 +0200
Message-Id: <1028809316.1770.13.camel@frda-linux.staff.tdk.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

anybody knows how to do this?

I was hoping to be able to set an option like "full_duplex=1" or
something when loading the module, but this doesn't work. Also doing a
"modinfo tg3" tells me there's only a debug parm (tg3_debug) for the
module.

Machine: Dell PowerEdge 2650
OS/kernel: SuSE 8 with standard kernel (2.4.18-64GB-SMP)

/var/log/messages output:
Aug  8 15:38:08 serv100 kernel: tg3.c:v0.97 (Mar 13, 2002)
Aug  8 15:38:08 serv100 kernel: eth0: Tigon3 [partno(BCM95701A10) rev
0105 PHY(5701)] (PCIX:133MHz:64-bit) 10/100/1000BaseT E
thernet 00:06:5b:3e:46:e2
Aug  8 15:38:08 serv100 kernel: eth1: Tigon3 [partno(BCM95701A10) rev
0105 PHY(5701)] (PCIX:133MHz:64-bit) 10/100/1000BaseT E
thernet 00:06:5b:3e:46:e3
Aug  8 15:38:08 serv100 kernel: eth0: Link is up at 100 Mbps, half
duplex.
Aug  8 15:38:08 serv100 kernel: eth0: Flow control is off for TX and off
for RX.

I also tried mii-tool on the interface which reports this:
SIOCGMIIPHY on 'eth0' failed: Operation not supported


Please let me know if more info from my part is needed for
troubleshooting. Many thanks in advance.

Best regards,
Frederik Dannemare


