Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265955AbTGROFF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 10:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270085AbTGROE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 10:04:27 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:23173
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S265955AbTGROEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 10:04:01 -0400
Date: Fri, 18 Jul 2003 15:18:22 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307181418.h6IEIMIF017756@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: fix qlogicfas build warning
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/drivers/scsi/qlogicfas.c linux-2.6.0-test1-ac2/drivers/scsi/qlogicfas.c
--- linux-2.6.0-test1/drivers/scsi/qlogicfas.c	2003-07-10 21:15:40.000000000 +0100
+++ linux-2.6.0-test1-ac2/drivers/scsi/qlogicfas.c	2003-07-14 15:51:53.000000000 +0100
@@ -140,6 +140,7 @@
 
 #include <asm/io.h>
 #include <asm/irq.h>
+#include <asm/dma.h>
 
 #include "scsi.h"
 #include "hosts.h"
