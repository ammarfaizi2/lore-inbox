Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262662AbUBZDSA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 22:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262642AbUBZDQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 22:16:40 -0500
Received: from palrel12.hp.com ([156.153.255.237]:31981 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S262649AbUBZDP2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 22:15:28 -0500
Date: Wed, 25 Feb 2004 19:15:27 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] static_w83977af
Message-ID: <20040226031527.GG32263@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

irXXX_static_w83977af.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [FEATURE] make more symbol static (namespace pollution)


diff -Nru a/drivers/net/irda/w83977af_ir.c b/drivers/net/irda/w83977af_ir.c
--- a/drivers/net/irda/w83977af_ir.c	Mon Jan 26 14:37:26 2004
+++ b/drivers/net/irda/w83977af_ir.c	Mon Jan 26 14:37:26 2004
@@ -679,7 +679,7 @@
  *
  *    
  */
-void w83977af_dma_xmit_complete(struct w83977af_ir *self)
+static void w83977af_dma_xmit_complete(struct w83977af_ir *self)
 {
 	int iobase;
 	__u8 set;
