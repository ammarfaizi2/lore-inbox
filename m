Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130017AbQLQMxj>; Sun, 17 Dec 2000 07:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131744AbQLQMxa>; Sun, 17 Dec 2000 07:53:30 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:34461 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S130017AbQLQMxS>; Sun, 17 Dec 2000 07:53:18 -0500
Date: Sun, 17 Dec 2000 12:22:50 +0000
From: Tim Waugh <twaugh@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.4.0-test13-pre2: ChangeLog sync
Message-ID: <20001217122250.B19671@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is a small patch that syncs up the parport ChangeLog to the
current source tree.

Tim.
*/

2000-12-13  Tim Waugh  <twaugh@redhat.com>

	* drivers/parport/ChangeLog: Resync.

--- linux-2.4.0-test12/drivers/parport/ChangeLog.sync	Wed Dec 13 12:37:45 2000
+++ linux-2.4.0-test12/drivers/parport/ChangeLog	Wed Dec 13 12:38:41 2000
@@ -9,6 +9,11 @@
 	* parport_pc.c (sio_via_686a_probe): Handle case
 	where hardware returns 255 for IRQ or DMA.
 
+2000-08-08  Cesar Eduardo Barros  <cesarb@nitnet.com.br>
+
+	* parport_pc.c (parport_pc_probe_port): Fix annoying printk to
+	console bug.
+
 2000-07-20  Eddie C. Dost  <ecd@skynet.be>
 
 	* share.c (attach_driver_chain): attach[i](port) needs to be
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
