Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262604AbSKIUYN>; Sat, 9 Nov 2002 15:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262621AbSKIUYN>; Sat, 9 Nov 2002 15:24:13 -0500
Received: from bilbo.math.uni-mannheim.de ([134.155.88.153]:28601 "HELO
	bilbo.math.uni-mannheim.de") by vger.kernel.org with SMTP
	id <S262604AbSKIUYM>; Sat, 9 Nov 2002 15:24:12 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Rolf Eike Beer <eike@bilbo.math.uni-mannheim.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.46 kill unneeded declaration from drivers/scsi/sim710.h
Date: Sat, 9 Nov 2002 21:33:37 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200211092133.37685@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Richard agreed that this is completely unneeded so we should just kill it.

Eike

--- linux-2.5.46/drivers/scsi/sim710.h	Mon Nov  4 23:30:29 2002
+++ linux-2.5.46-lacon/drivers/scsi/sim710.h	Sat Nov  9 21:26:11 2002
@@ -14,8 +14,6 @@
 int sim710_bus_reset(Scsi_Cmnd * SCpnt);
 int sim710_dev_reset(Scsi_Cmnd * SCpnt);
 int sim710_host_reset(Scsi_Cmnd * SCpnt);
-int sim710_biosparam(struct scsi_device *, struct block_device *,
-		sector_t, int*);
 #ifdef MODULE
 int sim710_release(struct Scsi_Host *);
 #else
