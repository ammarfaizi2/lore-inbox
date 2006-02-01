Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030306AbWBAFJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030306AbWBAFJE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 00:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030334AbWBAFJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 00:09:04 -0500
Received: from smtp101.sbc.mail.re2.yahoo.com ([68.142.229.104]:52402 "HELO
	smtp101.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030306AbWBAFJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 00:09:02 -0500
Message-Id: <20060201050733.509789000.dtor_core@ameritech.net>
References: <20060201045514.178498000.dtor_core@ameritech.net>
Date: Tue, 31 Jan 2006 23:55:16 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: [GIT PATCH 02/18] psmouse: set name for Genius mice
Content-Disposition: inline; filename=genius-fix-name.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: psmouse - set name for Genius mice

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/mouse/psmouse-base.c |    1 +
 1 files changed, 1 insertion(+)

Index: work/drivers/input/mouse/psmouse-base.c
===================================================================
--- work.orig/drivers/input/mouse/psmouse-base.c
+++ work/drivers/input/mouse/psmouse-base.c
@@ -403,6 +403,7 @@ static int genius_detect(struct psmouse 
 		set_bit(REL_WHEEL, psmouse->dev->relbit);
 
 		psmouse->vendor = "Genius";
+		psmouse->name = "Mouse";
 		psmouse->pktsize = 4;
 	}
 

