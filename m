Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264950AbTBOTVv>; Sat, 15 Feb 2003 14:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264962AbTBOTUv>; Sat, 15 Feb 2003 14:20:51 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:63760 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265168AbTBOTTm>; Sat, 15 Feb 2003 14:19:42 -0500
Subject: PATCH: mca 53c9x also needs mca-legacy
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Date: Sat, 15 Feb 2003 19:29:55 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18k80Z-0007KA-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/scsi/mca_53c9x.c linux-2.5.61-ac1/drivers/scsi/mca_53c9x.c
--- linux-2.5.61/drivers/scsi/mca_53c9x.c	2003-02-10 18:38:13.000000000 +0000
+++ linux-2.5.61-ac1/drivers/scsi/mca_53c9x.c	2003-02-15 02:42:31.000000000 +0000
@@ -40,6 +40,7 @@
 #include <linux/blk.h>
 #include <linux/proc_fs.h>
 #include <linux/stat.h>
+#include <linux/mca-legacy.h>
 
 #include "scsi.h"
 #include "hosts.h"
