Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263957AbTEFQVO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 12:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263905AbTEFQUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 12:20:11 -0400
Received: from mail.convergence.de ([212.84.236.4]:8905 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S263938AbTEFQN7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 12:13:59 -0400
Message-ID: <3EB7DFF6.7030309@convergence.de>
Date: Tue, 06 May 2003 18:16:54 +0200
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.3) Gecko/20030408
X-Accept-Language: de-at, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: torvalds@transmeta.com
Subject: [PATCH[[2.5][8-11] add dvb subsystem as a crc32 lib user
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------020802020404020606030609"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020802020404020606030609
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

this patch adds the dvb subsystem as a user of the crc32 functions.

Please review and apply.

Thanks
Michael Hunold.










--------------020802020404020606030609
Content-Type: text/plain;
 name="08-add-dvb-subsystem-as-a-crc32-lib-user.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="08-add-dvb-subsystem-as-a-crc32-lib-user.diff"

diff -uNrwB -x '*.o' --new-file linux-2.5.69/lib/Makefile linux-2.5.69.patch/lib/Makefile
--- linux-2.5.69/lib/Makefile	2003-05-06 13:15:51.000000000 +0200
+++ linux-2.5.69.patch/lib/Makefile	2003-02-26 11:56:04.000000000 +0100
@@ -29,6 +28,7 @@
 include $(TOPDIR)/drivers/usb/Makefile.lib
 include $(TOPDIR)/fs/Makefile.lib
 include $(TOPDIR)/net/bluetooth/bnep/Makefile.lib
+include $(TOPDIR)/drivers/media/dvb/dvb-core/Makefile.lib
 
 host-progs := gen_crc32table
 clean-files := crc32table.h

--------------020802020404020606030609--


