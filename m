Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161507AbWJ3V2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161507AbWJ3V2K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 16:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161508AbWJ3V2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 16:28:10 -0500
Received: from v813.rev.tld.pl ([195.149.226.213]:27526 "EHLO
	smtp.host4.kei.pl") by vger.kernel.org with ESMTP id S1161507AbWJ3V2I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 16:28:08 -0500
X-clamdmail: clamdmail 0.18a
From: Marcin Juszkiewicz <openembedded@hrw.one.pl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] add WEIDA microdrive into ide-cs.c
Date: Mon, 30 Oct 2006 22:28:09 +0100
User-Agent: KMail/1.9.5
Cc: linux-pcmcia@lists.infradead.org, Alan Cox <alan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610302228.10043.openembedded@hrw.one.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcin Juszkiewicz <openembedded@hrw.one.pl>

Microdrive reported by one of OpenEmbedded developers.

product info: "WEIDA", "TWTTI", ""
manfid: 0x000a, 0x0000
function: 4 (fixed disk)

Signed-off-by: Marcin Juszkiewicz <openembedded@hrw.one.pl>

---
Patch follow kernel version 2.6.19-rc3

diff --git a/drivers/ide/legacy/ide-cs.c b/drivers/ide/legacy/ide-cs.c
index bef4759..0b19596 100644
--- a/drivers/ide/legacy/ide-cs.c
+++ b/drivers/ide/legacy/ide-cs.c
@@ -410,6 +410,7 @@ static struct pcmcia_device_id ide_ids[]
        PCMCIA_DEVICE_PROD_ID1("TRANSCEND    512M   ", 0xd0909443),
        PCMCIA_DEVICE_PROD_ID12("TRANSCEND", "TS4GCF120", 0x709b1bf1, 0xf54a91c8),
        PCMCIA_DEVICE_PROD_ID12("WIT", "IDE16", 0x244e5994, 0x3e232852),
+       PCMCIA_DEVICE_PROD_ID12("WEIDA", "TWTTI", 0xcc7cf69c, 0x212bb918),
        PCMCIA_DEVICE_PROD_ID1("STI Flash", 0xe4a13209),
        PCMCIA_DEVICE_PROD_ID12("STI", "Flash 5.0", 0xbf2df18d, 0x8cb57a0e),
        PCMCIA_MFC_DEVICE_PROD_ID12(1, "SanDisk", "ConnectPlus", 0x7a954bd9, 0x74be00c6),


-- 
JID: hrw-jabber.org
OpenEmbedded developer/consultant


