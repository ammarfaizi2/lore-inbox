Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbTKZOd3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 09:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbTKZOd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 09:33:29 -0500
Received: from bilbo.math.uni-mannheim.de ([134.155.88.153]:54477 "EHLO
	bilbo.math.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S262652AbTKZOd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 09:33:27 -0500
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
Subject: Typo in patch for linux-2.6.0-test10/drivers/scsi/sata_svw.c
Date: Wed, 26 Nov 2003 15:37:34 +0100
User-Agent: KMail/1.5.4
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311261537.34402@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to send it to <benh at crashing.org> which is the mail address in
bkbits, but the mail bounced. So here it is again.
-------------

There is something missing.

Eike

--- linux-2.6.0-test10-eike/drivers/scsi/sata_svw.c     2003-11-26 15:25:07.000000000 +0100
+++ linux-2.6.0-test10/drivers/scsi/sata_svw.c  2003-11-26 15:30:22.000000000 +0100
@@ -317,7 +317,7 @@

        /* Clear a magic bit in SCR1 according to Darwin, those help
         * some funky seagate drives (though so far, those were already
-        * set by the firmware on the machines I had access to
+        * set by the firmware on the machines I had access to)
         */
        writel(readl(mmio_base + 0x80) & ~0x00040000, mmio_base + 0x80);

