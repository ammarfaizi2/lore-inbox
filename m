Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275568AbRJJMLv>; Wed, 10 Oct 2001 08:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275573AbRJJMLm>; Wed, 10 Oct 2001 08:11:42 -0400
Received: from mailgate.rz.uni-karlsruhe.de ([129.13.64.97]:45842 "EHLO
	mailgate.rz.uni-karlsruhe.de") by vger.kernel.org with ESMTP
	id <S275568AbRJJMLa>; Wed, 10 Oct 2001 08:11:30 -0400
Date: Wed, 10 Oct 2001 14:11:55 +0200
To: linux-kernel@vger.kernel.org
Subject: 2.4.11|IRDA|SMC-IRCC
Message-ID: <20011010141155.A17093@cip.wiwi.uni-karlsruhe.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
From: aj@cip.wiwi.uni-karlsruhe.de (Andreas Jellinghaus)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

found SMC SuperIO Chip (devid=0x0b rev=00 base=0x03f0): FDC37N972
SMC IrDA Controller found
 IrCC version 2.0, firport 0x280, sirport 0x2f8 dma=3, irq=3
IrDA: Registered device irda0
NETDEV WATCHDOG: irda0: transmit timed out
irda0: transmit timed out
spurious 8259A interrupt: IRQ7.
NETDEV WATCHDOG: irda0: transmit timed out
irda0: transmit timed out
...

dell latitude c600 laptop.
never tried irda before, so i don´t know if it can work at all,
but there are reports on the web, that it should work.

irdadump lists output, but doesn´t see other irda devices
(e.g. siemens s35i mobile phone).

CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_IRDA=m
CONFIG_IRCOMM=m
CONFIG_IRTTY_SIR=m
CONFIG_IRPORT_SIR=m
CONFIG_SMC_IRCC_FIR=m
CONFIG_SERIAL=m

serial                 43360   0  (unused)
smc-ircc                6416   1 
irport                  4560   1  [smc-ircc]
irda                   77664   1  [smc-ircc irport]

irattach is running. /proc/sys/net/irda/discovery is 1,
/proc/net/irda/discovery doesn´t find anything.

regards, andreas
