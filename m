Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270574AbTGNMLL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 08:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270578AbTGNMKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 08:10:49 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:42884
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S270574AbTGNMKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 08:10:39 -0400
Date: Mon, 14 Jul 2003 13:24:22 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307141224.h6ECOMNE030899@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, marcelo@conectiva.com
Subject: PATCH: more warning fixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.22-pre5/drivers/scsi/nsp32.h linux.22-pre5-ac1/drivers/scsi/nsp32.h
--- linux.22-pre5/drivers/scsi/nsp32.h	2003-07-14 12:26:48.000000000 +0100
+++ linux.22-pre5-ac1/drivers/scsi/nsp32.h	2003-07-07 15:56:54.000000000 +0100
@@ -425,5 +425,5 @@
 #define BUSPHASE_STATUS      ( BUSMON_STATUS      & BUSMON_PHASE_MASK )
 #define BUSPHASE_SELECT      ( BUSMON_SEL | BUSMON_IO )
 
-#endif _NSP32_H
+#endif /* _NSP32_H */
 /* end */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.22-pre5/drivers/scsi/nsp32_io.h linux.22-pre5-ac1/drivers/scsi/nsp32_io.h
--- linux.22-pre5/drivers/scsi/nsp32_io.h	2003-07-14 12:26:49.000000000 +0100
+++ linux.22-pre5-ac1/drivers/scsi/nsp32_io.h	2003-07-07 15:56:54.000000000 +0100
@@ -265,5 +265,5 @@
 	nsp32_multi_write4(base, FIFO_DATA_LOW, buf, count);
 }
 
-#endif _NSP32_IO_H
+#endif /* _NSP32_IO_H */
 /* end */
