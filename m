Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262531AbRE3Ax6>; Tue, 29 May 2001 20:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262483AbRE3Axt>; Tue, 29 May 2001 20:53:49 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:6927 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S262164AbRE3Axi>; Tue, 29 May 2001 20:53:38 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200105300054.CAA04625@green.mif.pg.gda.pl>
Subject: [PATCH] net #1 (correction)
To: alan@lxorguk.ukuu.org.uk (Alan Cox),
        jgarzik@mandrakesoft.com (Jeff Garzik), linux-net@vger.kernel.org,
        andrewm@uow.edu.au
Date: Wed, 30 May 2001 02:54:41 +0200 (CEST)
Cc: linux-kernel@vger.kernel.org (kernel list)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry, one fix against previous patch

Andrzej

--- drivers/net/wavelan.p.h~	Wed May 30 02:43:16 2001
+++ drivers/net/wavelan.p.h	Wed May 30 02:44:29 2001
@@ -705,9 +705,9 @@
 MODULE_PARM(io, "1-4i");
 MODULE_PARM(irq, "1-4i");
 MODULE_PARM(name, "1-4c" __MODULE_STRING(IFNAMSIZ));
-MODULE_PARM(io, "WaveLAN I/O base address(es),required");
-MODULE_PARM(irq, "WaveLAN IRQ number(s)");
-MODULE_PARM(name, "WaveLAN interface neme(s)");
+MODULE_PARM_DESC(io, "WaveLAN I/O base address(es),required");
+MODULE_PARM_DESC(irq, "WaveLAN IRQ number(s)");
+MODULE_PARM_DESC(name, "WaveLAN interface neme(s)");
 #endif	/* MODULE */
 
 #endif	/* WAVELAN_P_H */

-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
