Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267645AbRGUOqn>; Sat, 21 Jul 2001 10:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267647AbRGUOqd>; Sat, 21 Jul 2001 10:46:33 -0400
Received: from jdi.jdimedia.nl ([212.204.192.51]:50385 "EHLO jdi.jdimedia.nl")
	by vger.kernel.org with ESMTP id <S267645AbRGUOqa>;
	Sat, 21 Jul 2001 10:46:30 -0400
Date: Sat, 21 Jul 2001 16:46:12 +0200 (CEST)
From: Igmar Palsenberg <i.palsenberg@jdimedia.nl>
X-X-Sender: <igmar@jdi.jdimedia.nl>
To: <linux-kernel@vger.kernel.org>
Subject: PCMCIA modulair broken on 2.4.6
Message-ID: <Pine.LNX.4.33.0107211643280.27755-100000@jdi.jdimedia.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


Hi,

Compiling 2.4.6 with a modulair PCMCIA setup gives me :

[root@wrkst linux]# insmod pcmcia_core
Using /lib/modules/2.4.6/kernel/drivers/pcmcia/pcmcia_core.o
/lib/modules/2.4.6/kernel/drivers/pcmcia/pcmcia_core.o: unresolved symbol
pci_insert_device
/lib/modules/2.4.6/kernel/drivers/pcmcia/pcmcia_core.o: unresolved symbol
pci_setup_device
/lib/modules/2.4.6/kernel/drivers/pcmcia/pcmcia_core.o: unresolved symbol
pci_remove_device


Relevant .config stuff :

CONFIG_HOTPLUG=y
CONFIG_PCMCIA=m
CONFIG_CARDBUS=y
CONFIG_I82365=y

CONFIG_NET_RADIO=y
CONFIG_PCMCIA_HERMES=m
CONFIG_NET_WIRELESS=y

Please CC me, I'm not subscribed.


	Regards,


		Igmar



-- 

Igmar Palsenberg
JDI Media Solutions

Boulevard Heuvelink 102
6828 KT Arnhem
The Netherlands

mailto: i.palsenberg@jdimedia.nl
PGP/GPG key : http://www.jdimedia.nl/formulier/pgp/igmar

