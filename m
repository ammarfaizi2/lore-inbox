Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbTISTrZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 15:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbTISTrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 15:47:25 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:32932 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261686AbTISTrY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 15:47:24 -0400
Subject: [PATCH 1/5] input: Fix Set3 keycode for right control in atkbd.c
In-Reply-To: 
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Fri, 19 Sep 2003 21:47:14 +0200
Message-Id: <10640008343413@twilight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1350, 2003-09-19 13:15:12+02:00, Andries.Brouwer@cwi.nl
  input: Fix Set3 keycode for right control in atkbd.c


 atkbd.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

===================================================================

diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Fri Sep 19 14:13:04 2003
+++ b/drivers/input/keyboard/atkbd.c	Fri Sep 19 14:13:04 2003
@@ -71,7 +71,7 @@
 	134, 46, 45, 32, 18,  5,  4, 63,135, 57, 47, 33, 20, 19,  6, 64,
 	136, 49, 48, 35, 34, 21,  7, 65,137,100, 50, 36, 22,  8,  9, 66,
 	125, 51, 37, 23, 24, 11, 10, 67,126, 52, 53, 38, 39, 25, 12, 68,
-	113,114, 40, 84, 26, 13, 87, 99,100, 54, 28, 27, 43, 84, 88, 70,
+	113,114, 40, 84, 26, 13, 87, 99, 97, 54, 28, 27, 43, 84, 88, 70,
 	108,105,119,103,111,107, 14,110,  0, 79,106, 75, 71,109,102,104,
 	 82, 83, 80, 76, 77, 72, 69, 98,  0, 96, 81,  0, 78, 73, 55, 85,
 	 89, 90, 91, 92, 74,185,184,182,  0,  0,  0,125,126,127,112,  0,

