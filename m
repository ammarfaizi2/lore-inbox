Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135283AbREFKCn>; Sun, 6 May 2001 06:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135296AbREFKCd>; Sun, 6 May 2001 06:02:33 -0400
Received: from monster.totalnet.ro ([212.54.96.3]:45072 "HELO
	monster.totalnet.ro") by vger.kernel.org with SMTP
	id <S135283AbREFKCY>; Sun, 6 May 2001 06:02:24 -0400
Date: Sun, 6 May 2001 13:05:09 +0300 (EEST)
From: Claudiu Constantinescu <klaus@totalnet.ro>
To: linux-kernel@vger.kernel.org
Subject: O2Micro PCMCIA card support
Message-ID: <Pine.LNX.4.21.0105061304120.8055-100000@puzzlewell.totalnet.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	I couldn't find info on it in the archives, so I decided to post the
question on the list. I am using an o2micro pcmcia socket and two pcmcia cards,
a modem and an Asix AX88190A network card, all of which work fine with kernel
2.2 and pcmcia-cs, plus the vendor's drivers for the Asix card. On 2.4.4
however, the i82365 module fails to detect the card (looking through the sources
it seems that it probes only the ISA bus?), but the yenta module (mistakenly?)
detects it as an yenta socket, but tries to load two memory_cs modules instead
of the appropriate card drivers. The output of lspci shows:

00:03.0 CardBus bridge: O2 Micro, Inc. 6836 (rev 62)
00:03.1 CardBus bridge: O2 Micro, Inc. 6836 (rev 62)

	Am I missing something or is the support for this card broken?

	One more thing: Is there any planned support for AX88190 cards? The
vendor distributed modified version of 8390 driver is available only
for pcmcia-cs, but sometimes freezes the whole system.

	Please CC to my personal address, since i am not subscribed to the
list. Thank you.

Regards,
Claudiu Constantinescu

------
"Sunt prea ocupat cu pierdutul timpului ca sa am timp de ceva util" - Andrei Panzar


