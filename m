Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262602AbSKIUXJ>; Sat, 9 Nov 2002 15:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262604AbSKIUXI>; Sat, 9 Nov 2002 15:23:08 -0500
Received: from bilbo.math.uni-mannheim.de ([134.155.88.153]:28345 "HELO
	bilbo.math.uni-mannheim.de") by vger.kernel.org with SMTP
	id <S262602AbSKIUXI>; Sat, 9 Nov 2002 15:23:08 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Rolf Eike Beer <eike@bilbo.math.uni-mannheim.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.20-rc1 kill unneeded declaration from drivers/scsi/sim710.h
Date: Sat, 9 Nov 2002 21:32:33 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200211092132.33047@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Richard agreed that this is completely unneeded so we should just kill it.

Eike

--- linux-2.4.20-rc1-lacon/drivers/scsi/sim710.h.orig	Sat Nov  9 21:21:58 2002
+++ linux-2.4.20-rc1-lacon/drivers/scsi/sim710.h	Sat Nov  9 21:22:30 2002
@@ -14,7 +14,6 @@
 int sim710_bus_reset(Scsi_Cmnd * SCpnt);
 int sim710_dev_reset(Scsi_Cmnd * SCpnt);
 int sim710_host_reset(Scsi_Cmnd * SCpnt);
-int sim710_biosparam(Disk *, kdev_t, int*);
 #ifdef MODULE
 int sim710_release(struct Scsi_Host *);
 #else
