Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbUEVPBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbUEVPBs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 11:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbUEVPBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 11:01:48 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:12500 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261505AbUEVPBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 11:01:34 -0400
Date: Sat, 22 May 2004 17:01:27 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, linux-net@vger.kernel.org
Subject: [2.6 patch] more comx removal
Message-ID: <20040522150127.GS18564@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removes the MAINTAINERS entry for the removed comx 
driver.

Additionally, the following comx header files could be removed:
  drivers/net/wan/mixcom.h
  drivers/net/wan/hscx.h
  drivers/net/wan/munich32x.h
  drivers/net/wan/falc-lh.h

I've double-checked that none of them are used by any other driver.

cu
Adrian


--- linux-2.6.6-mm5-full/MAINTAINERS.old	2004-05-22 14:48:10.000000000 +0200
+++ linux-2.6.6-mm5-full/MAINTAINERS	2004-05-22 16:59:35.000000000 +0200
@@ -530,11 +530,6 @@
 L:	linux-computone@lazuli.wittsend.com
 S:	Supported
 
-COMX/MULTIGATE SYNC SERIAL DRIVERS
-P:	Pasztor Szilard
-M:	Pasztor Szilard <don@itc.hu>
-S:	Supported
-
 COSA/SRP SYNC SERIAL DRIVER
 P:	Jan "Yenya" Kasprzak
 M:	kas@fi.muni.cz
