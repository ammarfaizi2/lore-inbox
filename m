Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269007AbUHMF4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269007AbUHMF4u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 01:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265152AbUHMF4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 01:56:50 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:40858 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S269007AbUHMF4V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 01:56:21 -0400
Subject: acpi shutdown problem on SMP (tyan tiger mp, athlon)
From: Alexander Rauth <Alexander.Rauth@promotion-ie.de>
Reply-To: Alexander.Rauth@promotion-ie.de
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Pro/Motion Industrie-Elektronik GmbH
Message-Id: <1092376617.8529.13.camel@pro30.local.promotion-ie.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 13 Aug 2004 07:56:57 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this problem first appeared in vanilla-2.6.2 and is still present in
vanilla-2.6.8-rc4 (vanilla-2.6.1 worked fine)

on shutdown the disks spin down, the VGA switches to powersave, but the
cpu-fans and the power-supply won't power down.

Anyone has a hint for me?

Thanks,
Alexander

hardware: Tyan Tiger MP (s2460) BIOS v1.05
lspci
0000:00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP
[IGD4-2P] System Controller (rev 11)
0000:00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP
[IGD4-2P] AGP Bridge
0000:00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-766
[ViperPlus] ISA (rev 02)
0000:00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-766
[ViperPlus] IDE (rev 01)
0000:00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-766 [ViperPlus]
ACPI (rev 01)
0000:00:07.4 USB Controller: Advanced Micro Devices [AMD] AMD-766
[ViperPlus] USB (rev 07)
0000:00:08.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1
(rev 07)
0000:00:08.1 Input device controller: Creative Labs SB Live! MIDI/Game
Port (rev 07)
0000:00:0c.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M
[Tornado] (rev 74)
0000:01:05.0 VGA compatible controller: ATI Technologies Inc Radeon
RV100 QY [Radeon 7000/VE]


