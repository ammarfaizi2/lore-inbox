Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265061AbRFZRlX>; Tue, 26 Jun 2001 13:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265062AbRFZRlN>; Tue, 26 Jun 2001 13:41:13 -0400
Received: from ams8uucp0.ams.ops.eu.uu.net ([212.153.111.69]:59615 "EHLO
	ams8uucp0.ams.ops.eu.uu.net") by vger.kernel.org with ESMTP
	id <S265061AbRFZRlC>; Tue, 26 Jun 2001 13:41:02 -0400
Date: Tue, 26 Jun 2001 19:28:23 +0200 (CEST)
From: kees <kees@schoen.nl>
To: linux-kernel@vger.kernel.org
Subject: NETDEV WATCHDOG with 2.4.5
Message-ID: <Pine.LNX.4.21.0106261924220.10865-100000@schoen3.schoen.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I tried 2.4.5 but after a couple of hours I lost all network connectivety.
The log shows:


Jun 25 19:34:17 schoen3 kernel: NETDEV WATCHDOG: eth0: transmit timed out
Jun 25 19:34:17 schoen3 kernel: eth0: Tx timed out, lost
interrupt? TSR=0x3, ISR=0Jun 25 19:34:19 schoen3 kernel: NETDEV
WATCHDOG: eth0: transmit timed out
Jun 25 19:34:19 schoen3 kernel: eth0: Tx timed out, lost
interrupt? TSR=0x3, ISR=0Jun 25 19:34:21 schoen3 kernel: NETDEV
WATCHDOG: eth0: transmit timed out
Jun 25 19:34:21 schoen3 kernel: eth0: Tx timed out, lost
interrupt? TSR=0x3, ISR=0/tmp/NETDEV


O well, back to 2.2.19 again. The network card is 

<6>ne2k-pci.c: v1.02 for Linux 2.2, 10/19/2000, D. Becker/P. Gortmaker,
http://www<4>ne2k-pci.c: PCI NE2000 clone 'Compex RL2000' at I/O 0xec00,
IRQ 19.
<4>eth0: Compex RL2000 found at 0xec00, IRQ 19, 00:80:48:CA:1D:4C.

regards 
Kees

