Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267904AbTBRSFK>; Tue, 18 Feb 2003 13:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267972AbTBRSCs>; Tue, 18 Feb 2003 13:02:48 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:29705 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267971AbTBRSAQ>; Tue, 18 Feb 2003 13:00:16 -0500
Subject: PATCH: fix path of file
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 18 Feb 2003 18:10:36 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18lCCS-000695-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/legacy/ali14xx.c linux-2.5.61-ac2/drivers/ide/legacy/ali14xx.c
--- linux-2.5.61/drivers/ide/legacy/ali14xx.c	2003-02-10 18:38:01.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/legacy/ali14xx.c	2003-02-18 18:06:19.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/ide/ali14xx.c		Version 0.03	Feb 09, 1996
+ *  linux/drivers/ide/legacy/ali14xx.c		Version 0.03	Feb 09, 1996
  *
  *  Copyright (C) 1996  Linus Torvalds & author (see below)
  */
