Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262297AbVBQPDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262297AbVBQPDg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 10:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262191AbVBQPBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 10:01:05 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:58373 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261411AbVBQO7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 09:59:46 -0500
Date: Thu, 17 Feb 2005 15:59:43 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jgarzik@pobox.com
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/3c527.c: make a struct static
Message-ID: <20050217145943.GK24808@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global struct static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc3-mm2-full/drivers/net/3c527.c.old	2005-02-16 15:13:19.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/3c527.c	2005-02-16 15:13:29.000000000 +0100
@@ -197,7 +197,7 @@
 	char		*name;
 };
 
-const struct mca_adapters_t mc32_adapters[] = {
+static const struct mca_adapters_t mc32_adapters[] = {
 	{ 0x0041, "3COM EtherLink MC/32" },
 	{ 0x8EF5, "IBM High Performance Lan Adapter" },
 	{ 0x0000, NULL }

