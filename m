Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263980AbTFUNjy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 09:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264067AbTFUNjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 09:39:37 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:22946 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S263980AbTFUNiE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 09:38:04 -0400
Subject: [PATCH 4/11] input: Remove unused var from serio struct
In-Reply-To: <10562035173660@twilight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Sat, 21 Jun 2003 15:51:57 +0200
Message-Id: <10562035173172@twilight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1362, 2003-06-21 04:35:24-07:00, davej@codemonkey.org.uk
  input: remove unused var from serio struct


 serio.h |    1 -
 1 files changed, 1 deletion(-)

===================================================================

diff -Nru a/include/linux/serio.h b/include/linux/serio.h
--- a/include/linux/serio.h	Sat Jun 21 15:25:14 2003
+++ b/include/linux/serio.h	Sat Jun 21 15:25:14 2003
@@ -26,7 +26,6 @@
 	void *driver;
 	char *name;
 	char *phys;
-	int number;
 
 	unsigned short idbus;
 	unsigned short idvendor;

