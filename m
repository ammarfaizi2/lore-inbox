Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129573AbRAFGGI>; Sat, 6 Jan 2001 01:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129741AbRAFGF6>; Sat, 6 Jan 2001 01:05:58 -0500
Received: from gandalf.math.uni-mannheim.de ([134.155.88.152]:27142 "EHLO
	gandalf.math.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S129534AbRAFGFu>; Sat, 6 Jan 2001 01:05:50 -0500
From: Matthias Juchem <juchem@uni-mannheim.de>
To: torvalds@transmeta.com
Subject: [PATCHlet]: removal of redundant line in documentation
Date: Sat, 6 Jan 2001 06:51:58 +0100
X-Mailer: KMail [version 1.0.29.2]
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01010607054600.01947@gandalf>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus.

Step [7.3] is redundant because it is
already handled by the ver_linux script

This patch is against 2.4.0

Matthias

--- REPORTING-BUGS.orig	Sat Jan  6 06:49:12 2001
+++ REPORTING-BUGS	Sat Jan  6 06:47:57 2001
@@ -45,11 +45,10 @@
 [7.] Environment
 [7.1.] Software (add the output of the ver_linux script here)
 [7.2.] Processor information (from /proc/cpuinfo):
-[7.3.] Module information (from /proc/modules):
-[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
-[7.5.] PCI information ('lspci -vvv' as root)
-[7.6.] SCSI information (from /proc/scsi/scsi)
-[7.7.] Other information that might be relevant to the problem
+[7.3.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
+[7.4.] PCI information ('lspci -vvv' as root)
+[7.5.] SCSI information (from /proc/scsi/scsi)
+[7.6.] Other information that might be relevant to the problem
        (please look in /proc and include all information that you
        think to be relevant):
 [X.] Other notes, patches, fixes, workarounds:
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
