Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263126AbTIVMb3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 08:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263128AbTIVMb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 08:31:29 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:55292 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263126AbTIVMbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 08:31:17 -0400
Date: Mon, 22 Sep 2003 14:31:11 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux@syskonnect.de
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org, jgarzik@pobox.com
Subject: [2.6 patch] remove unused CONFIG_SK98LIN_T*
Message-ID: <20030922123111.GU6325@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Current 2.6 contains a bunch of CONFIG_SK98LIN_T* options that are:
- used nowhere
- wrong, since the resulting varaibles are CONFIG_CONFIG_SK98LIN_T*

The patch below removes these options.

diffstat output:

 drivers/net/Kconfig |  134 --------------------------------------------
 1 files changed, 134 deletions(-)


cu
Adrian

--- linux-2.6.0-test5-mm4-no-smp-2.95/drivers/net/Kconfig.old	2003-09-22 14:02:17.000000000 +0200
+++ linux-2.6.0-test5-mm4-no-smp-2.95/drivers/net/Kconfig	2003-09-22 14:03:53.000000000 +0200
@@ -2118,140 +2118,6 @@
 	  say M here and read Documentation/modules.txt. This is recommended.
 	  The module will be called sk98lin.o.
 	  
-config CONFIG_SK98LIN_T1
-	bool "3Com 3C940/3C941 Gigabit Ethernet Adapter"
-	depends on SK98LIN
-	help
-	  This driver supports:
-	  
-	    - 3Com 3C940 Gigabit LOM Ethernet Adapter
-	    - 3Com 3C941 Gigabit LOM Ethernet Adapter
-	
-	  Questions concerning this driver may be addressed to:
-	      linux@syskonnect.de
-	
-config CONFIG_SK98LIN_T2
-	bool "Allied Telesyn AT-29xx Gigabit Ethernet Adapter"
-	depends on SK98LIN
-	help
-	  This driver supports:
-	  
-	    - Allied Telesyn AT-2970SX Gigabit Ethernet Adapter
-	    - Allied Telesyn AT-2970LX Gigabit Ethernet Adapter
-	    - Allied Telesyn AT-2970TX Gigabit Ethernet Adapter
-	    - Allied Telesyn AT-2971SX Gigabit Ethernet Adapter
-	    - Allied Telesyn AT-2971T Gigabit Ethernet Adapter
-	    - Allied Telesyn AT-2970SX/2SC Gigabit Ethernet Adapter
-	    - Allied Telesyn AT-2970LX/2SC Gigabit Ethernet Adapter
-	    - Allied Telesyn AT-2970TX/2TX Gigabit Ethernet Adapter
-	
-	  Questions concerning this driver may be addressed to:
-	      linux@syskonnect.de
-	
-config CONFIG_SK98LIN_T3
-	bool "CNet N-Way Gigabit Ethernet Adapter"
-	depends on SK98LIN
-	help
-	  This driver supports:
-	  
-	    - N-Way PCI-Bus Giga-Card 1000/100/10Mbps(L)
-	
-	  Questions concerning this driver may be addressed to:
-	      linux@syskonnect.de
-	
-config CONFIG_SK98LIN_T4
-	bool "D-Link DGE-530T Gigabit Ethernet Adapter"
-	depends on SK98LIN
-	help
-	  This driver supports:
-	  
-	    - DGE-530T Gigabit Ethernet Adapter
-	
-	  Questions concerning this driver may be addressed to:
-	      linux@syskonnect.de
-	
-config CONFIG_SK98LIN_T5
-	bool "Linksys EG10xx Ethernet Server Adapter"
-	depends on SK98LIN
-	help
-	  This driver supports:
-	  
-	    - EG1032 v2 Instant Gigabit Network Adapter
-	    - EG1064 v2 Instant Gigabit Network Adapter
-	
-	  Questions concerning this driver may be addressed to:
-	      linux@syskonnect.de
-	
-config CONFIG_SK98LIN_T6
-	bool "Marvell RDK-80xx Adapter"
-	depends on SK98LIN
-	help
-	  This driver supports:
-	  
-	    - Marvell RDK-8001 Adapter
-	    - Marvell RDK-8002 Adapter
-	    - Marvell RDK-8003 Adapter
-	    - Marvell RDK-8004 Adapter
-	    - Marvell RDK-8006 Adapter
-	    - Marvell RDK-8007 Adapter
-	    - Marvell RDK-8008 Adapter
-	    - Marvell RDK-8009 Adapter
-	    - Marvell RDK-8011 Adapter
-	    - Marvell RDK-8012 Adapter
-	
-	  Questions concerning this driver may be addressed to:
-	      linux@syskonnect.de
-	
-config CONFIG_SK98LIN_T7
-	bool "Marvell Yukon Gigabit Ethernet Adapter"
-	depends on SK98LIN
-	help
-	  This driver supports:
-	  
-	    - Marvell Yukon Gigabit Ethernet 10/100/1000Base-T Adapter
-	
-	  Questions concerning this driver may be addressed to:
-	      linux@syskonnect.de
-	
-config CONFIG_SK98LIN_T8
-	bool "SysKonnect SK-98xx Server Gigabit Adapter"
-	depends on SK98LIN
-	help
-	  This driver supports:
-	  
-	    - SK-9821 Gigabit Ethernet Server Adapter (SK-NET GE-T)
-	    - SK-9822 Gigabit Ethernet Server Adapter (SK-NET GE-T dual link)
-	    - SK-9841 Gigabit Ethernet Server Adapter (SK-NET GE-LX)
-	    - SK-9842 Gigabit Ethernet Server Adapter (SK-NET GE-LX dual link)
-	    - SK-9843 Gigabit Ethernet Server Adapter (SK-NET GE-SX)
-	    - SK-9844 Gigabit Ethernet Server Adapter (SK-NET GE-SX dual link)
-	    - SK-9861 Gigabit Ethernet Server Adapter (SK-NET GE-SX Volition)
-	    - SK-9862 Gigabit Ethernet Server Adapter (SK-NET GE-SX Volition dual link)
-	    - SK-9871 Gigabit Ethernet Server Adapter (SK-NET GE-ZX)
-	    - SK-9872 Gigabit Ethernet Server Adapter (SK-NET GE-ZX dual link)
-	
-	  Questions concerning this driver may be addressed to:
-	      linux@syskonnect.de
-	
-config CONFIG_SK98LIN_T9
-	bool "SysKonnect SK-98xx V2.0 Gigabit Ethernet Adapter"
-	depends on SK98LIN
-	help
-	  This driver supports:
-	  
-	    - SK-9521 V2.0 10/100/1000Base-T Adapter
-	    - SK-9821 V2.0 Gigabit Ethernet 10/100/1000Base-T Adapter
-	    - SK-9841 V2.0 Gigabit Ethernet 1000Base-LX Adapter
-	    - SK-9843 V2.0 Gigabit Ethernet 1000Base-SX Adapter
-	    - SK-9851 V2.0 Gigabit Ethernet 1000Base-SX Adapter
-	    - SK-9861 V2.0 Gigabit Ethernet 1000Base-SX Adapter
-	    - SK-9871 V2.0 Gigabit Ethernet 1000Base-ZX Adapter
-	    - SK-9521 10/100/1000Base-T Adapter
-	  
-	  Questions concerning this driver may be addressed to:
-	      linux@syskonnect.de
-	  
-
 
 config TIGON3
 	tristate "Broadcom Tigon3 support"
