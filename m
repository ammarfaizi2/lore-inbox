Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbULJUre@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbULJUre (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 15:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbULJUrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 15:47:33 -0500
Received: from thumbler.kulnet.kuleuven.ac.be ([134.58.240.45]:27072 "EHLO
	thumbler.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S261167AbULJUrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 15:47:09 -0500
Message-ID: <41BA0B77.9000902@mech.kuleuven.ac.be>
Date: Fri, 10 Dec 2004 21:47:51 +0100
From: Panagiotis Issaris <panagiotis.issaris@mech.kuleuven.ac.be>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: XGI Volari XP5 PCI device ID
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------020904060305040409030301"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020904060305040409030301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Some Dell Inspiron 5160s are now shipped with a
XGI Volari XP5. The card's PCI vendor identifier
is 1023, which represents Trident. XGI bought Trident
in june 2003.

This trivial patch adds the PCI device ID to the database.

With friendly regards,
Takis

-- 
------------------------------------------------------------------------
Panagiotis Issaris
Katholieke Universiteit Leuven
Division Production Engineering,
Machine Design and Automation
Celestijnenlaan 300B              panagiotis.issaris@mech.kuleuven.ac.be
B-3001 Leuven Belgium                 http://www.mech.kuleuven.ac.be/pma
------------------------------------------------------------------------


--------------020904060305040409030301
Content-Type: text/x-patch;
 name="pi-200412120-linux-pci_volari_xp5.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pi-200412120-linux-pci_volari_xp5.diff"

diff -ru /home/pissaris/livecd/linux-2.6.9/drivers/pci/pci.ids linux-2.6.9/drivers/pci/pci.ids
--- /home/pissaris/livecd/linux-2.6.9/drivers/pci/pci.ids	2004-11-29 00:24:21.000000000 +0100
+++ linux-2.6.9/drivers/pci/pci.ids	2004-12-10 18:30:42.000000000 +0100
@@ -1133,6 +1133,7 @@
 	2001  4DWave NX
 		122d 1400  Trident PCI288-Q3DII (NX)
 	2100  CyberBlade XP4m32
+	2200  Volari XP5
 	8400  CyberBlade/i7
 		1023 8400  CyberBlade i7 AGP
 	8420  CyberBlade/i7d

--------------020904060305040409030301--
