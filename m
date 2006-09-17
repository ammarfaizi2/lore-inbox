Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbWIQBsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbWIQBsF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 21:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWIQBrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 21:47:55 -0400
Received: from mrs.stonybrook.edu ([129.49.1.206]:48581 "EHLO
	mrs.stonybrook.edu") by vger.kernel.org with ESMTP id S932118AbWIQBrn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 21:47:43 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 2 of 11] EICON ISDN: Removed unused definitions for OS_SEEK_*
X-Mercurial-Node: e90cdef08ec341a6aac18f7be6b6ef9ea0050bbf
Message-Id: <e90cdef08ec341a6aac1.1158455368@turing.ams.sunysb.edu>
In-Reply-To: <patchbomb.1158455366@turing.ams.sunysb.edu>
Date: Sat, 16 Sep 2006 21:09:28 -0400
From: "Josef 'Jeff' Sipek" <jeffpc@josefsipek.net>
To: linux-kernel@vger.kernel.org
Cc: kkeil@suse.de, mac@melware.de, akpm@osdl.org, dhowells@redhat.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

EICON ISDN: Removed unused definitions for OS_SEEK_*

Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>

--

diff -r 115dd6f4c050 -r e90cdef08ec3 drivers/isdn/hardware/eicon/dsp_defs.h
--- a/drivers/isdn/hardware/eicon/dsp_defs.h	Sat Sep 16 21:00:45 2006 -0400
+++ b/drivers/isdn/hardware/eicon/dsp_defs.h	Sat Sep 16 21:00:45 2006 -0400
@@ -34,9 +34,6 @@
  *
  * I/O functions returns -1 on error, 0 on EOF
  */
-#define OS_SEEK_SET 0
-#define OS_SEEK_CUR 1
-#define OS_SEEK_END 2
 struct _OsFileHandle_;
 typedef long (  * OsFileIo)  (struct _OsFileHandle_    *handle,
                                 void                     *buffer,


