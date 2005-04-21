Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261294AbVDULTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbVDULTo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 07:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbVDULSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 07:18:11 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:19845 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261292AbVDULRW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 07:17:22 -0400
Date: Thu, 21 Apr 2005 13:15:41 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [patch] hp100: fix card names
Message-ID: <20050421111541.GA24697@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Those cards really need A in their names. Otherwise it is pretty hard
to find anything about them on the net.

Signed-off-by: Pavel Machek <pavel@suse.cz>

--- clean/drivers/net/hp100.c	2005-03-03 12:34:19.000000000 +0100
+++ linux/drivers/net/hp100.c	2005-03-22 12:20:53.000000000 +0100
@@ -13,8 +13,8 @@
 ** This driver has only been tested with
 ** -- HP J2585B 10/100 Mbit/s PCI Busmaster
 ** -- HP J2585A 10/100 Mbit/s PCI 
-** -- HP J2970  10 Mbit/s PCI Combo 10base-T/BNC
-** -- HP J2973  10 Mbit/s PCI 10base-T
+** -- HP J2970A 10 Mbit/s PCI Combo 10base-T/BNC
+** -- HP J2973A 10 Mbit/s PCI 10base-T
 ** -- HP J2573  10/100 ISA
 ** -- Compex ReadyLink ENET100-VG4  10/100 Mbit/s PCI / EISA
 ** -- Compex FreedomLine 100/VG  10/100 Mbit/s ISA / EISA / PCI

-- 
Boycott Kodak -- for their patent abuse against Java.
