Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131094AbQLKXvi>; Mon, 11 Dec 2000 18:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131156AbQLKXv2>; Mon, 11 Dec 2000 18:51:28 -0500
Received: from [200.222.195.150] ([200.222.195.150]:5636 "EHLO
	pervalidus.dyndns.org") by vger.kernel.org with ESMTP
	id <S131094AbQLKXvN>; Mon, 11 Dec 2000 18:51:13 -0500
Date: Mon, 11 Dec 2000 21:20:27 -0200
From: Frédéric L . W . Meunier 
	<0@pervalidus.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ide-pci.c: typo
Message-ID: <20001211212027.A1245@pervalidus>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
X-Mailer: Mutt/1.2.5i - Linux 2.2.18
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

dmesg: VP_IDE: not 100% native mode: will probe irqs later
syslog: Dec 11 14:28:48 pervalidus kernel: VP_IDE: not 100%% native mode: will probe irqs later


-- 
0@pervalidus.{net,{dyndns.}org} TelFax: 55-21-717-2399 (Niterói-RJ BR)

--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ide-pci.c.diff"

--- linux/drivers/block/ide-pci.c.old	Sun Dec 10 23:10:22 2000
+++ linux/drivers/block/ide-pci.c	Mon Dec 11 20:16:36 2000
@@ -344,7 +344,7 @@
 	 */
 	pciirq = dev->irq;
 	if ((dev->class & ~(0xfa)) != ((PCI_CLASS_STORAGE_IDE << 8) | 5)) {
-		printk("%s: not 100%% native mode: will probe irqs later\n", d->name);
+		printk("%s: not 100% native mode: will probe irqs later\n", d->name);
 		pciirq = ide_special_settings(dev, d->name);
 	} else if (tried_config) {
 		printk("%s: will probe irqs later\n", d->name);

--W/nzBZO5zC0uMSeA--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
