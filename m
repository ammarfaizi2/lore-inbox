Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316996AbSHaJz5>; Sat, 31 Aug 2002 05:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316997AbSHaJz5>; Sat, 31 Aug 2002 05:55:57 -0400
Received: from smtp.mujoskar.cz ([217.77.161.140]:29947 "EHLO smtp.mujoskar.cz")
	by vger.kernel.org with ESMTP id <S316996AbSHaJz5>;
	Sat, 31 Aug 2002 05:55:57 -0400
Content-Type: text/plain; charset=US-ASCII
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: linux-kernel@vger.kernel.org
Subject: smc-ircc freeze kernel
Date: Sat, 31 Aug 2002 11:59:17 +0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17l52I-0000NL-00@notas>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I use 2.4.19 kernel with notebook Dell Latitude CPx J650

I modprobe these modules:
irlan                  19252   0 (unused)
smc-ircc                6720   1
irport                  4856   0 [smc-ircc]
irda                   81744   1 [irlan smc-ircc irport]

kernel tells me:
found SMC SuperIO Chip (devid=0x09 rev=08 base=0x03f0): FDC37N958FR
SMC IrDA Controller found
 IrCC version 1.1, firport 0x290, sirport 0x3e8 dma=3, irq=0
IrDA: Registered device irda0

ifconfig tells me:
irda0     Link encap:IrLAP  HWaddr 00:00:00:00
          UP RUNNING NOARP  MTU:2048  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:8
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
          Base address:0x3e8

then when I simply tells:
ifconfig irda0 192.168.1.1 netmask 255.255.255.0
my kernel freeze after 3 seconds and only numlock and scrolllock blinks

I dont have any other computer on other side at the moment I write ifconfig.

Thanks for solution

Michal
