Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263073AbTDVK7z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 06:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263074AbTDVK7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 06:59:55 -0400
Received: from 20.Red-80-39-3.pooles.rima-tde.net ([80.39.3.20]:41516 "EHLO
	localhost") by vger.kernel.org with ESMTP id S263073AbTDVK7y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 06:59:54 -0400
From: "Pedro A. Gracia Fajardo" <pgracia@iter.rcanaria.es>
Organization: ITER
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Added VIA 6103 10/100Mbps Phyceiver in sis900.c
Date: Tue, 22 Apr 2003 12:11:56 +0100
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200304221211.56347.pgracia@iter.rcanaria.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The actual driver can't find the VIA 6103 Phyceiver in PC CHIPS M810D MOBOs.  
I used the mii_chip_table from etherboot project.

--- sis900.c    2003-04-22 09:39:29.000000000 +0100
+++ sis900.c-via6103    2003-04-22 11:50:36.000000000 +0100
@@ -125,6 +125,7 @@
        { "ICS LAN PHY",                        0x0015, 0xF440, LAN },
        { "NS 83851 PHY",                       0x2000, 0x5C20, MIX },
        { "Realtek RTL8201 PHY",                0x0000, 0x8200, LAN },
+       { "VIA 6103 PHY",                       0x0101, 0x8f20, LAN },
        {0,},
 };

Regards, Pedro

-- 
Pedro A. Gracia Fajardo
Instituto Tecnológico de Energías Renovables (ITER)
