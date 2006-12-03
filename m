Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760036AbWLCTh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760036AbWLCTh2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 14:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760037AbWLCTh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 14:37:28 -0500
Received: from ftp.linux-mips.org ([194.74.144.162]:2285 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S1760036AbWLCTh1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 14:37:27 -0500
Date: Sun, 3 Dec 2006 19:37:21 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org
Subject: [MMC] Fix syntax error
Message-ID: <20061203193721.GA20896@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix syntax error introduced in ab7aefd0b38297e6d2d71f43e8f81f9f4a36cdae.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/drivers/mmc/au1xmmc.c b/drivers/mmc/au1xmmc.c
index 447fba5..6aac498 100644
--- a/drivers/mmc/au1xmmc.c
+++ b/drivers/mmc/au1xmmc.c
@@ -875,7 +875,7 @@ static void au1xmmc_init_dma(struct au1x
 	host->rx_chan = rxchan;
 }
 
-struct const mmc_host_ops au1xmmc_ops = {
+const struct mmc_host_ops au1xmmc_ops = {
 	.request	= au1xmmc_request,
 	.set_ios	= au1xmmc_set_ios,
 };
