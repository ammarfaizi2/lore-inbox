Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268728AbUI3ErL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268728AbUI3ErL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 00:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268726AbUI3ErK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 00:47:10 -0400
Received: from fw.osdl.org ([65.172.181.6]:28823 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268716AbUI3Eq7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 00:46:59 -0400
Date: Wed, 29 Sep 2004 21:44:47 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, torvalds <torvalds@osdl.org>, pc300@cyclades.com
Subject: [PATCH 2.6.9-rc3] pc300: remove extra paren.
Message-Id: <20040929214447.207d3003.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Remove an extra left-paren.

diffstat:=
 drivers/net/wan/pc300_tty.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>


diff -Naurp ./drivers/net/wan/pc300_tty.c~build_pc300 ./drivers/net/wan/pc300_tty.c
--- ./drivers/net/wan/pc300_tty.c~build_pc300	2004-09-29 21:19:04.848661808 -0700
+++ ./drivers/net/wan/pc300_tty.c	2004-09-29 21:37:15.854803664 -0700
@@ -704,7 +704,7 @@ static void cpc_tty_rx_work(void * data)
 					ld = tty_ldisc_ref(cpc_tty);
 					if(ld)
 					{
-						if (ld->receive_buf)) {
+						if (ld->receive_buf) {
 							CPC_TTY_DBG("%s: call line disc. receive_buf\n",cpc_tty->name);
 							ld->receive_buf(cpc_tty->tty, (char *)(buf->data), &flags, buf->size);
 						}


--
