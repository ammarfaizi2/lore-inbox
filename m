Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261696AbVFFX5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbVFFX5j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 19:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbVFFX5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 19:57:36 -0400
Received: from rav-az.mvista.com ([65.200.49.157]:48416 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S261696AbVFFXwg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 19:52:36 -0400
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: [PATCH][RIO] -mm: Fix macro indenting
In-Reply-To: mporter@kernel.crashing.org
X-Mailer: gregkh_patchbomb
Date: Mon, 6 Jun 2005 16:52:21 -0700
Message-Id: <1118101941657@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Matt Porter <mporter@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up indenting that Lindent fubared.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org

commit 87ff3372a005e4cf927b1b62c23e1c2339d46507
tree 16e1d9454a95a4a1e8b9e50dacd218f8e14dfe14
parent 6e9e41d480cf54c69d47df11f5cba696461ebe1a
author Matt Porter <mporter@kernel.crashing.org> Mon, 06 Jun 2005 09:23:49 -0700
committer Matt Porter <mporter@kernel.crashing.org> Mon, 06 Jun 2005 09:23:49 -0700

 drivers/rio/rio-access.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/rio/rio-access.c b/drivers/rio/rio-access.c
--- a/drivers/rio/rio-access.c
+++ b/drivers/rio/rio-access.c
@@ -77,13 +77,13 @@ int __rio_local_write_config_##size \
 }
 
 RIO_LOP_READ(8, u8, 1)
-    RIO_LOP_READ(16, u16, 2)
-    RIO_LOP_READ(32, u32, 4)
-    RIO_LOP_WRITE(8, u8, 1)
-    RIO_LOP_WRITE(16, u16, 2)
-    RIO_LOP_WRITE(32, u32, 4)
+RIO_LOP_READ(16, u16, 2)
+RIO_LOP_READ(32, u32, 4)
+RIO_LOP_WRITE(8, u8, 1)
+RIO_LOP_WRITE(16, u16, 2)
+RIO_LOP_WRITE(32, u32, 4)
 
-    EXPORT_SYMBOL(__rio_local_read_config_8);
+EXPORT_SYMBOL(__rio_local_read_config_8);
 EXPORT_SYMBOL(__rio_local_read_config_16);
 EXPORT_SYMBOL(__rio_local_read_config_32);
 EXPORT_SYMBOL(__rio_local_write_config_8);
@@ -137,13 +137,13 @@ int rio_mport_write_config_##size \
 }
 
 RIO_OP_READ(8, u8, 1)
-    RIO_OP_READ(16, u16, 2)
-    RIO_OP_READ(32, u32, 4)
-    RIO_OP_WRITE(8, u8, 1)
-    RIO_OP_WRITE(16, u16, 2)
-    RIO_OP_WRITE(32, u32, 4)
+RIO_OP_READ(16, u16, 2)
+RIO_OP_READ(32, u32, 4)
+RIO_OP_WRITE(8, u8, 1)
+RIO_OP_WRITE(16, u16, 2)
+RIO_OP_WRITE(32, u32, 4)
 
-    EXPORT_SYMBOL(rio_mport_read_config_8);
+EXPORT_SYMBOL(rio_mport_read_config_8);
 EXPORT_SYMBOL(rio_mport_read_config_16);
 EXPORT_SYMBOL(rio_mport_read_config_32);
 EXPORT_SYMBOL(rio_mport_write_config_8);


