Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265839AbRGJHDB>; Tue, 10 Jul 2001 03:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265813AbRGJHCv>; Tue, 10 Jul 2001 03:02:51 -0400
Received: from patan.Sun.COM ([192.18.98.43]:39408 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S265839AbRGJHCf>;
	Tue, 10 Jul 2001 03:02:35 -0400
Message-ID: <3B4AAA48.77108442@sun.com>
Date: Tue, 10 Jul 2001 00:10:00 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: alan@redhat.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH]  Makefile nits
Content-Type: multipart/mixed;
 boundary="------------A99E4C65DA669400A91A6C83"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------A99E4C65DA669400A91A6C83
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Alan,

Attached is a simple patch that adds some of the dynamic files in the
aic7xxx build to the make clean rule.

Tim

-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
--------------A99E4C65DA669400A91A6C83
Content-Type: text/plain; charset=us-ascii;
 name="makefile_misc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="makefile_misc.diff"

diff -ruN dist-2.4.6/Makefile cobalt-2.4.6/Makefile
--- dist-2.4.6/Makefile	Mon Jul  2 17:46:42 2001
+++ cobalt-2.4.6/Makefile	Mon Jul  9 11:09:01 2001
@@ -196,6 +197,10 @@
 	drivers/zorro/devlist.h drivers/zorro/gen-devlist \
 	drivers/sound/bin2hex drivers/sound/hex2hex \
 	drivers/atm/fore200e_mkfirm drivers/atm/{pca,sba}*{.bin,.bin1,.bin2} \
+	drivers/scsi/aic7xxx/aicasm/aicasm_gram.c \
+	drivers/scsi/aic7xxx/aicasm/aicasm_scan.c \
+	drivers/scsi/aic7xxx/aicasm/y.tab.h \
+	drivers/scsi/aic7xxx/aicasm/aicasm \
 	net/khttpd/make_times_h \
 	net/khttpd/times.h \
 	submenu*

--------------A99E4C65DA669400A91A6C83--

