Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265732AbTFNU0F (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 16:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265734AbTFNU0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 16:26:05 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:65257 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S265732AbTFNUZu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 16:25:50 -0400
Date: Sat, 14 Jun 2003 22:39:34 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] input: Add hiragana/katakana keys to atkbd.c [4/13]
Message-ID: <20030614223934.C25997@ucw.cz>
References: <20030614223513.A25948@ucw.cz> <20030614223629.A25997@ucw.cz> <20030614223708.B25997@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030614223708.B25997@ucw.cz>; from vojtech@suse.cz on Sat, Jun 14, 2003 at 10:37:08PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1215.104.21, 2003-06-09 13:55:51+02:00, miura@da-cha.org
  input: Add default mapping for the hiragana/katakana key.


 atkbd.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

===================================================================

diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Sat Jun 14 22:22:20 2003
+++ b/drivers/input/keyboard/atkbd.c	Sat Jun 14 22:22:20 2003
@@ -39,7 +39,7 @@
 
 static unsigned char atkbd_set2_keycode[512] = {
 	  0, 67, 65, 63, 61, 59, 60, 88,  0, 68, 66, 64, 62, 15, 41, 85,
-	  0, 56, 42,  0, 29, 16,  2, 89,  0,  0, 44, 31, 30, 17,  3, 90,
+	  0, 56, 42,182, 29, 16,  2, 89,  0,  0, 44, 31, 30, 17,  3, 90,
 	  0, 46, 45, 32, 18,  5,  4, 91,  0, 57, 47, 33, 20, 19,  6,  0,
 	  0, 49, 48, 35, 34, 21,  7,  0,  0,  0, 50, 36, 22,  8,  9,  0,
 	  0, 51, 37, 23, 24, 11, 10,  0,  0, 52, 53, 38, 39, 25, 12,  0,
