Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316582AbSGQTZ6>; Wed, 17 Jul 2002 15:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316585AbSGQTZ5>; Wed, 17 Jul 2002 15:25:57 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:6046 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S316582AbSGQTZy> convert rfc822-to-8bit; Wed, 17 Jul 2002 15:25:54 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <mcp@linux-systeme.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19-rc1|rc2 -> err, what? 
Date: Wed, 17 Jul 2002 21:28:27 +0200
X-Mailer: KMail [version 1.4]
Organization: Linux-Systeme GmbH
X-PRIORITY: 2 (High)
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200207172128.27292.mcp@linux-systeme.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

--- linux.orig/Makefile 2002-06-24 16:13:49.000000000 +0000
+++ linux/Makefile      2002-06-24 15:23:35.000000000 +0000
@@ -201,10 +204,15 @@
        drivers/zorro/devlist.h drivers/zorro/gen-devlist \
        drivers/sound/bin2hex drivers/sound/hex2hex \
        drivers/atm/fore200e_mkfirm drivers/atm/{pca,sba}*{.bin,.bin1,.bin2} \
+       drivers/scsi/aic7xxx/aicasm/aicasm \
        drivers/scsi/aic7xxx/aicasm/aicasm_gram.c \
+       drivers/scsi/aic7xxx/aicasm/aicasm_gram.h \
+       drivers/scsi/aic7xxx/aicasm/aicasm_macro_gram.c \
+       drivers/scsi/aic7xxx/aicasm/aicasm_macro_gram.h \
+       drivers/scsi/aic7xxx/aicasm/aicasm_macro_scan.c \
        drivers/scsi/aic7xxx/aicasm/aicasm_scan.c \
+       drivers/scsi/aic7xxx/aicasm/aicdb.h \
        drivers/scsi/aic7xxx/aicasm/y.tab.h \
-       drivers/scsi/aic7xxx/aicasm/aicasm \
        drivers/scsi/53c700_d.h \
        net/khttpd/make_times_h \
        net/khttpd/times.h \

please, where are those files? aicdb.h, *_macro_* ?


Please CC, i am not subscribed!

-- 
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/408B2D54947750EC
Fingerprint: 8602 69E0 A9C2 A509 8661 2B0B 408B 2D54 9477 50EC
Key available at www.keyserver.net. Encrypted e-mail preferred.
