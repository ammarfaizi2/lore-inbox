Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbUKMWwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbUKMWwt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 17:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbUKMWwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 17:52:49 -0500
Received: from hera.cwi.nl ([192.16.191.8]:31872 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261197AbUKMWws (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 17:52:48 -0500
Date: Sat, 13 Nov 2004 23:52:44 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] __devinit in ide/pci/rz1000.c
Message-ID: <20041113225243.GA22786@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -uprN -X /linux/dontdiff a/drivers/ide/pci/rz1000.c b/drivers/ide/pci/rz1000.c
--- a/drivers/ide/pci/rz1000.c	2004-10-30 21:44:00.000000000 +0200
+++ b/drivers/ide/pci/rz1000.c	2004-11-14 00:00:04.000000000 +0100
@@ -33,7 +33,7 @@
 
 #include <asm/io.h>
 
-static void __init init_hwif_rz1000 (ide_hwif_t *hwif)
+static void __devinit init_hwif_rz1000 (ide_hwif_t *hwif)
 {
 	u16 reg;
 	struct pci_dev *dev = hwif->pci_dev;
