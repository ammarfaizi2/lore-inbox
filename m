Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271469AbTGROFF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 10:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265955AbTGROEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 10:04:32 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:22405
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S271589AbTGROD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 10:03:28 -0400
Date: Fri, 18 Jul 2003 15:17:49 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307181417.h6IEHnsL017750@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: pas16 build fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/drivers/scsi/pas16.c linux-2.6.0-test1-ac2/drivers/scsi/pas16.c
--- linux-2.6.0-test1/drivers/scsi/pas16.c	2003-07-10 21:04:04.000000000 +0100
+++ linux-2.6.0-test1-ac2/drivers/scsi/pas16.c	2003-07-14 15:51:03.000000000 +0100
@@ -117,6 +117,7 @@
 #include <linux/proc_fs.h>
 #include <linux/sched.h>
 #include <asm/io.h>
+#include <asm/dma.h>
 #include <linux/blk.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
