Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264639AbUFGL5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264639AbUFGL5t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 07:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264419AbUFGL5C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 07:57:02 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:65152 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S264426AbUFGLzf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 07:55:35 -0400
To: torvalds@osdl.org, akpm@osdl.org, vojtech@ucw.cz,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
Message-Id: <10866093531034@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <1086609353132@twilight.ucw.cz>
Mime-Version: 1.0
Date: Mon, 7 Jun 2004 13:55:53 +0200
Subject: [PATCH 8/39] input: Fix trailing whitespace in atkbd
X-Mailer: gregkh_patchbomb_levon_offspring
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input-for-linus

===================================================================

ChangeSet@1.1371.753.15, 2004-04-23 02:39:09-05:00, dtor_core@ameritech.net
  Input: fix trailing whitespace in atkbd


 atkbd.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

===================================================================

diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	2004-06-07 13:13:10 +02:00
+++ b/drivers/input/keyboard/atkbd.c	2004-06-07 13:13:10 +02:00
@@ -814,12 +814,12 @@
 		param[0] = (test_bit(LED_SCROLLL, atkbd->dev.led) ? 1 : 0)
 		         | (test_bit(LED_NUML,    atkbd->dev.led) ? 2 : 0)
  		         | (test_bit(LED_CAPSL,   atkbd->dev.led) ? 4 : 0);
-		
+
 		if (atkbd_probe(atkbd))
 			return -1;
 		if (atkbd->set != atkbd_set_3(atkbd))
 			return -1;
-		
+
 		atkbd_enable(atkbd);
 
 		if (atkbd_command(atkbd, param, ATKBD_CMD_SETLEDS))

