Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263846AbTDGXQV (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 19:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263829AbTDGXPe (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:15:34 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:65408
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263846AbTDGXJw (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 19:09:52 -0400
Date: Tue, 8 Apr 2003 01:28:42 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080028.h380Sgf9009157@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: compatmac is not needed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/drivers/serial/68360serial.c linux-2.5.67-ac1/drivers/serial/68360serial.c
--- linux-2.5.67/drivers/serial/68360serial.c	2003-03-18 16:46:50.000000000 +0000
+++ linux-2.5.67-ac1/drivers/serial/68360serial.c	2003-04-04 00:03:46.000000000 +0100
@@ -39,7 +39,6 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <asm/irq.h>
-#include <linux/compatmac.h>
 #include <asm/m68360.h>
 #include <asm/commproc.h>
 
