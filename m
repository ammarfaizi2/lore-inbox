Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318983AbSHFEcA>; Tue, 6 Aug 2002 00:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318984AbSHFEcA>; Tue, 6 Aug 2002 00:32:00 -0400
Received: from 24.213.60.124.up.mi.chartermi.net ([24.213.60.124]:20125 "EHLO
	front2.chartermi.net") by vger.kernel.org with ESMTP
	id <S318983AbSHFEb5>; Tue, 6 Aug 2002 00:31:57 -0400
From: Nathaniel Russell <reddog83@chartermi.net>
Reply-To: reddog83@chartermi.net
Organization: RedDog GNu/Linux
To: reddog83@chartermi.net
Subject: [PATCH] trivial patch for 2.4.20-pre1 8139too.c driver
Date: Tue, 6 Aug 2002 00:31:58 +0000
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_A5CEF4H3ZVOVIV1L60IR"
Message-Id: <200208060031.58600.reddog83@chartermi.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_A5CEF4H3ZVOVIV1L60IR
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

This patch removes unneeded code for the Realtek driver this patch does n=
ot
harm the performance of the driver at all it just removes dead code
--------------Boundary-00=_A5CEF4H3ZVOVIV1L60IR
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="diff"

diff -urN linux-2.4/drivers/net/8139too.c.tmp linux/drivers/net/8139too.c
--- linux-2.4/drivers/net/8139too.c.tmp	Mon Aug  5 18:06:03 2002
+++ linux/drivers/net/8139.c	Tue Aug  6 00:09:20 2002
@@ -211,7 +211,6 @@
 	RTL8139 = 0,
 	RTL8139_CB,
 	SMC1211TX,
-	/*MPX5030,*/
 	DELTA8139,
 	ADDTRON8139,
 	DFE538TX,
@@ -230,7 +229,6 @@
 	{ "RealTek RTL8139 Fast Ethernet", RTL8139_CAPS },
 	{ "RealTek RTL8139B PCI/CardBus", RTL8139_CAPS },
 	{ "SMC1211TX EZCard 10/100 (RealTek RTL8139)", RTL8139_CAPS },
-/*	{ MPX5030, "Accton MPX5030 (RealTek RTL8139)", RTL8139_CAPS },*/
 	{ "Delta Electronics 8139 10/100BaseTX", RTL8139_CAPS },
 	{ "Addtron Technolgy 8139 10/100BaseTX", RTL8139_CAPS },
 	{ "D-Link DFE-538TX (RealTek RTL8139)", RTL8139_CAPS },
@@ -245,7 +243,6 @@
 	{0x10ec, 0x8139, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8139 },
 	{0x10ec, 0x8138, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8139_CB },
 	{0x1113, 0x1211, PCI_ANY_ID, PCI_ANY_ID, 0, 0, SMC1211TX },
-/*	{0x1113, 0x1211, PCI_ANY_ID, PCI_ANY_ID, 0, 0, MPX5030 },*/
 	{0x1500, 0x1360, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DELTA8139 },
 	{0x4033, 0x1360, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ADDTRON8139 },
 	{0x1186, 0x1300, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DFE538TX },

--------------Boundary-00=_A5CEF4H3ZVOVIV1L60IR--

