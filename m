Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262615AbVBYF4C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262615AbVBYF4C (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 00:56:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262624AbVBYF4C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 00:56:02 -0500
Received: from mta3.srv.hcvlny.cv.net ([167.206.5.69]:48579 "EHLO
	mta3.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S262615AbVBYFz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 00:55:56 -0500
Date: Fri, 25 Feb 2005 00:56:23 -0500
From: Robert Wilkens <robw@optonline.net>
Subject: Patch - Misnomer
To: linux-kernel@vger.kernel.org
Message-id: <1109310983.6674.5.camel@localhost.localdomain>
MIME-version: 1.0
X-Mailer: Evolution 2.0.3
Content-type: text/plain
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below is patch for the SCSI sr.c driver, there was a mis-nomer referring
to the rewritable CD-ROM drive.

Rob
===========================================================================

--- kernel-source-2.6.10.old/drivers/scsi/sr.c  2004-12-24
16:35:50.000000000 -0500
+++ kernel-source-2.6.10.nwo/drivers/scsi/sr.c  2005-02-25
00:28:15.299421808 -0500
@@ -839,7 +839,7 @@
               cd->cdi.speed,
               buffer[n + 3] & 0x01 ? "writer " : "", /* CD Writer */
               buffer[n + 3] & 0x20 ? "dvd-ram " : "",
-              buffer[n + 2] & 0x02 ? "cd/rw " : "", /* can read
rewriteable */
+              buffer[n + 2] & 0x02 ? "cd-rw " : "", /* can read
rewriteable */
               buffer[n + 4] & 0x20 ? "xa/form2 " : "", /* can read
xa/from2 */
               buffer[n + 5] & 0x01 ? "cdda " : "", /* can read audio
data */
               loadmech[buffer[n + 6] >> 5]);


