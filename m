Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261274AbRFKPTe>; Mon, 11 Jun 2001 11:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261268AbRFKPTY>; Mon, 11 Jun 2001 11:19:24 -0400
Received: from kaiser.cip.physik.uni-muenchen.de ([141.84.136.1]:1542 "EHLO
	kaiser.cip.physik.uni-muenchen.de") by vger.kernel.org with ESMTP
	id <S261217AbRFKPTR>; Mon, 11 Jun 2001 11:19:17 -0400
Date: Mon, 11 Jun 2001 17:19:15 +0200 (CEST)
From: "Andreas K. Huettel" <Andreas.Huettel@Physik.Uni-Muenchen.DE>
Reply-To: "Andreas K. Huettel" <andreas@akhuettel.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.5-ac13, ASUS A7A266, still "clock timer configuration lost"
Message-ID: <Pine.LNX.4.21.0106111701050.1089-100000@ankogel.cip.physik.uni-muenchen.de>
X-Information: My public GPG key can be obtained at http://www.akhuettel.de/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear experts, 

subject says it all: 2.4.5-ac13, ASUS A7A266 board.

Jun 11 17:10:12 qubit kernel: probable hardware bug: clock timer
configuration lost - probably a VIA686a motherboard.
Jun 11 17:10:12 qubit kernel: probable hardware bug: restoring chip
configuration.

every 1-5 minutes. Definitely no VIA chips on board. Do you have any
ideas - is this a false alarm? BTW, once I saw soon after boot: 

Jun 11 15:05:18 qubit kernel: spurious 8259A interrupt: IRQ7.

Looking at time.c this might be related?

more info on request.
best regards, andreas


lspci:
00:00.0 Host bridge: Acer Laboratories Inc. [ALi]: Unknown device 1647
(rev 04)
00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M5247
00:02.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03)
00:04.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c4)
00:05.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev
10)
00:06.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03)
00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge
[Aladdin IV]
00:0b.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink]
(rev 74)
00:11.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
01:00.0 VGA compatible controller: nVidia Corporation NV11 (rev a1) 



---------------------------------------------------------------------
Andreas K. Huettel          andreas@akhuettel.de
81627 Muenchen              huettel@qubit.org
Germany                     http://www.akhuettel.de/
---------------------------------------------------------------------  
Please use GNUPG or PGP for signed and encrypted email. My public key 
can be found at http://www.akhuettel.de/pgp_key.html
---------------------------------------------------------------------  



