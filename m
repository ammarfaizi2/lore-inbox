Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268142AbTAKTiH>; Sat, 11 Jan 2003 14:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268136AbTAKThs>; Sat, 11 Jan 2003 14:37:48 -0500
Received: from AMarseille-201-1-4-231.abo.wanadoo.fr ([217.128.74.231]:9584
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S268138AbTAKThg>; Sat, 11 Jan 2003 14:37:36 -0500
Subject: Re: [PATCH] sl82c105 driver update
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <1042302798.525.66.camel@zion.wanadoo.fr>
References: <1042302798.525.66.camel@zion.wanadoo.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042314384.541.78.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 11 Jan 2003 20:46:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Then add this one on top of it ;)

Ben.


--- 1.7/drivers/ide/pci/sl82c105.c      Sat Jan 11 17:24:47 2003
+++ edited/drivers/ide/pci/sl82c105.c   Sat Jan 11 20:44:51 2003
@@ -470,7 +470,7 @@
          */
        hwif->drives[0].pio_speed = XFER_PIO_0;
        hwif->drives[0].autotune = 1;
-       hwif->drives[1].pio_speed = XFER_PIO_1;
+       hwif->drives[1].pio_speed = XFER_PIO_0;
        hwif->drives[1].autotune = 1;
  
        pci_read_config_dword(dev, 0x40, &val);

