Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293249AbSCZL2J>; Tue, 26 Mar 2002 06:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311203AbSCZL17>; Tue, 26 Mar 2002 06:27:59 -0500
Received: from correo.e-technik.uni-ulm.de ([134.60.21.81]:45325 "EHLO
	correo.e-technik.uni-ulm.de") by vger.kernel.org with ESMTP
	id <S293249AbSCZL1w>; Tue, 26 Mar 2002 06:27:52 -0500
Message-Id: <200203261127.MAA05078@correo.e-technik.uni-ulm.de>
Content-Type: text/plain; charset=US-ASCII
From: Kai-Boris Schad <kschad@correo.e-technik.uni-ulm.de>
Reply-To: kschad@correo.e-technik.uni-ulm.de
Organization: =?iso8859-15?q?Universit=E4t?= Ulm
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.4.17 with VT8367 [KT266] crashes on heavy ide load togeter with heavy network load
Date: Tue, 26 Mar 2002 12:27:50 +0100
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

I have problems with PC mainboard using the Via VT8367 [KT266] chipset.  
lspci shows the configuration:
lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8367 [KT266]
00:01.0 PCI bridge: VIA Technologies, Inc. VT8367 [KT266 AGP]
00:0c.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
00:0e.0 Unknown mass storage controller: Promise Technology, Inc. 20268 (rev 
01)00:0f.0 Unknown mass storage controller: Promise Technology, Inc. 20268 
(rev 01)00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
01:00.0 VGA compatible controller: ATI Technologies Inc Rage XL AGP (rev 27)

The CPU is a 1400MHz Athlon. 
We use this system for a software Raid 5. If we produce heavy load on the 
disks and network the system hangs. There is no log of errors at all. We 
tried to change the network card form a 3com to a rtl83xx. The system remains 
a litle longer stable but crashes then too. We also tried to have the 
harddisks on seperate ide channels but this didn't solve the crashs. 
It seems to be something with the dma, because if we disable the dma of the 
harddisks the system is stable. Does anybody also recognise this problem ?
Is there any solution for this effect ?

Thanks a lot 

Kai


