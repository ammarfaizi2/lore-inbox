Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbTIAUxu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 16:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263266AbTIAUxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 16:53:50 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:20719 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262108AbTIAUxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 16:53:49 -0400
Date: Mon, 1 Sep 2003 22:53:41 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: pgmdsg@ibi.com
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [2.6 patch] remove an unused variable in riscom8.c
Message-ID: <20030901205341.GD23729@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removes an unused variable in drivers/char/riscom8.c

I've tested the compilation with 2.6.0-test4-mm4.

Please apply
Adrian

--- linux-2.6.0-test4-mm4-no-smp/drivers/char/riscom8.c.old	2003-09-01 22:21:57.000000000 +0200
+++ linux-2.6.0-test4-mm4-no-smp/drivers/char/riscom8.c	2003-09-01 22:22:55.000000000 +0200
@@ -1036,7 +1036,6 @@
 	int error;
 	struct riscom_port * port;
 	struct riscom_board * bp;
-	unsigned long flags;
 	
 	board = RC_BOARD(tty->index);
 	if (board >= RC_NBOARD || !(rc_board[board].flags & RC_BOARD_PRESENT))
