Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262410AbTESLdC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 07:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262412AbTESLdC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 07:33:02 -0400
Received: from smtp.wp.pl ([212.77.101.161]:23211 "EHLO smtp.wp.pl")
	by vger.kernel.org with ESMTP id S262410AbTESLc7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 07:32:59 -0400
Date: Mon, 19 May 2003 13:45:46 +0200
From: "=?ISO-8859-2?Q?Rafa=B3?= 'rmrmg' Roszak" <rmrmg@wp.pl>
To: linux-kernel@vger.kernel.org
Subject: [isdn] avm fritz pci
Message-Id: <20030519134546.4c4395bf.rmrmg@wp.pl>
X-Mailer: Sylpheed version 0.9.0 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiVirus: skaner antywirusowy poczty Wirtualnej Polski S. A.
X-WP-ChangeAV: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have kernel 2.4.21-rc2  (I also tested 2.4.20 2.4.21-pre6, pre7 and
rc1) and when I use 2 channels connect, system crash. Hisax modul is
loaded with parametrs: 
modprobe hisax protocol=2 type=27


System: Slackware 9.0
gcc 3.2.3 (only 2.4.21-rc2 was compiled by this version, rest by
gcc-3.2.2 from slackware package)
isdn4k-utils-3.2p1

[root@slack:~#] lspci -vvv

00:0b.0 Network controller: AVM Audiovisuelles MKTG & Computer System
GmbH A1 ISDN [Fritz] (rev 02)	Subsystem: AVM Audiovisuelles MKTG &
Computer System GmbH FRITZ!Card ISDN Controller	Control: I/O+ Mem+ BusMaster-
SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-	Status: Cap-
66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort-
>SERR- <PERR-
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at ec000000 (32-bit, non-prefetchable) [size=32]
	Region 1: I/O ports at 7400 [size=32]



-- 
registered Linux user 261525 | Wszystko jest trudne przy
gg 2311504________rmrmg@wp.pl|    odpowiednim stopniu
RMRMG signature version 0.0.2|        abstrakcji
