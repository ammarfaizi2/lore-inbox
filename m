Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262539AbTDAOO3>; Tue, 1 Apr 2003 09:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262546AbTDAOO2>; Tue, 1 Apr 2003 09:14:28 -0500
Received: from SMTP6.andrew.cmu.edu ([128.2.10.86]:44516 "EHLO
	smtp6.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id <S262539AbTDAOO1>; Tue, 1 Apr 2003 09:14:27 -0500
Date: Tue, 1 Apr 2003 09:25:51 -0500 (EST)
From: Steinar Hauan <steinhau@andrew.cmu.edu>
To: linux-kernel@vger.kernel.org
Subject: [trivial] make xconfig for 2.4.21-pre6
Message-ID: <Pine.LNX.4.53L-031.0304010923300.3945@unix44.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

  "make xconfig" fails for recent 2.4.21-preX versions; typo.

--- linux-2.4.21-pre6/drivers/net/Config.in.FCS	2003-04-01 09:06:30.000000000 -0500
+++ linux-2.4.21-pre6/drivers/net/Config.in	2003-04-01 09:06:39.000000000 -0500
@@ -185,7 +185,7 @@
       dep_tristate '    Davicom DM910x/DM980x support' CONFIG_DM9102 $CONFIG_PCI
       dep_tristate '    EtherExpressPro/100 support (eepro100, original Becker driver)' CONFIG_EEPRO100 $CONFIG_PCI
       if [ "$CONFIG_VISWS" = "y" ]; then
-         define_mbool CONFIG_EEPRO100_PIO y
+         define_bool CONFIG_EEPRO100_PIO y
       else
          dep_mbool '      Use PIO instead of MMIO' CONFIG_EEPRO100_PIO $CONFIG_EEPRO100
       fi

--
  Steinar Hauan, dept of ChemE  --  hauan@cmu.edu
  Carnegie Mellon University, Pittsburgh PA, USA
