Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262806AbVFVGWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262806AbVFVGWj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 02:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262818AbVFVGUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 02:20:45 -0400
Received: from mail.kroah.org ([69.55.234.183]:37020 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262807AbVFVFWI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:22:08 -0400
Cc: tklauser@nuerscht.ch
Subject: [PATCH] I2C: Spelling fixes for drivers/i2c/algos/i2c-algo-pca.c
In-Reply-To: <1119417465718@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:17:45 -0700
Message-Id: <11194174651514@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: Spelling fixes for drivers/i2c/algos/i2c-algo-pca.c

This patch fixes the some misspellings and a trailing whitespace in
the comments.

Signed-off-by: Tobias Klauser <tklauser@nuerscht.ch>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 46b615f453202dbcf66452b500ab69c0e2148593
tree 4f2a4daab8bc675ed72c435cb7cee8e0ad78e751
parent 6f637a6494a1872c613fe68f64ea4831c3e5b037
author Tobias Klauser <tklauser@nuerscht.ch> Thu, 19 May 2005 22:27:23 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:51:59 -0700

 drivers/i2c/algos/i2c-algo-pca.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-pca.c b/drivers/i2c/algos/i2c-algo-pca.c
--- a/drivers/i2c/algos/i2c-algo-pca.c
+++ b/drivers/i2c/algos/i2c-algo-pca.c
@@ -62,7 +62,7 @@ static void pca_start(struct i2c_algo_pc
 }
 
 /*
- * Generate a repeated start condition on the i2c bus 
+ * Generate a repeated start condition on the i2c bus
  *
  * return after the repeated start condition has occurred
  */
@@ -82,7 +82,7 @@ static void pca_repeated_start(struct i2
  * returns after the stop condition has been generated
  *
  * STOPs do not generate an interrupt or set the SI flag, since the
- * part returns the the idle state (0xf8). Hence we don't need to
+ * part returns the idle state (0xf8). Hence we don't need to
  * pca_wait here.
  */
 static void pca_stop(struct i2c_algo_pca_data *adap)

