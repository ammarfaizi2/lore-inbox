Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315282AbSF3PUc>; Sun, 30 Jun 2002 11:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315277AbSF3PSv>; Sun, 30 Jun 2002 11:18:51 -0400
Received: from se1.cogenit.fr ([195.68.53.173]:9921 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S315278AbSF3PRr>;
	Sun, 30 Jun 2002 11:17:47 -0400
Date: Sun, 30 Jun 2002 17:20:10 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.24 - drivers/net/tlan.c dma mapping 10/10
Message-ID: <20020630172009.L19347@fafner.intra.cogenit.fr>
References: <Pine.LNX.4.44.0206232229570.922-100000@localhost.localdomain> <20020624084325.B22534@fafner.intra.cogenit.fr> <20020624211407.A23939@fafner.intra.cogenit.fr> <3D17743E.8060905@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D17743E.8060905@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Mon, Jun 24, 2002 at 03:34:22PM -0400
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- changelog update.

--- linux-2.5.24/drivers/net/tlan.c	Sun Jun 30 15:13:20 2002
+++ linux-2.5.24/drivers/net/tlan.c	Sun Jun 30 16:10:08 2002
@@ -164,6 +164,8 @@
  *	v1.15 Apr 4, 2002    - Correct operation when aui=1 to be
  *	                       10T half duplex no loopback
  *	                       Thanks to Gunnar Eikman
+ *
+ *	v1.16 Jun 30, 2002   - DMA mapping conversion <romieu@cogenit.fr>
  *******************************************************************************/
 
 #include <linux/module.h>
@@ -218,7 +220,7 @@ static	int		bbuf;
 static	dma_addr_t	TLanPadBuffer_dma;
 static	u8		*TLanPadBuffer;
 static	char		TLanSignature[] = "TLAN";
-static const char tlan_banner[] = "ThunderLAN driver v1.15\n";
+static const char tlan_banner[] = "ThunderLAN driver v1.16\n";
 static int tlan_have_pci;
 static int tlan_have_eisa;
 
