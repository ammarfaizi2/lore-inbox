Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267904AbUG2PGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267904AbUG2PGx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 11:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267882AbUG2PAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 11:00:22 -0400
Received: from styx.suse.cz ([82.119.242.94]:11414 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S264833AbUG2OIJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:08:09 -0400
To: torvalds@osdl.org, vojtech@suse.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 13/47] Add a missing dmi_noloop declaration in i8042.c
Content-Transfer-Encoding: 7BIT
Date: Thu, 29 Jul 2004 16:09:55 +0200
X-Mailer: gregkh_patchbomb_levon_offspring
In-Reply-To: <10911101941591@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Message-Id: <1091110195981@twilight.ucw.cz>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1722.84.5, 2004-06-02 16:30:53+02:00, vojtech@suse.cz
  input: Add a missong dmi_noloop declaration in i8042.c
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>


 i8042.c |    1 +
 1 files changed, 1 insertion(+)

===================================================================

diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	Thu Jul 29 14:41:26 2004
+++ b/drivers/input/serio/i8042.c	Thu Jul 29 14:41:26 2004
@@ -53,6 +53,7 @@
 MODULE_PARM_DESC(dumbkbd, "Pretend that controller can only read data from keyboard");
 
 static unsigned int i8042_noloop;
+extern unsigned int i8042_dmi_noloop;
 
 __obsolete_setup("i8042_noaux");
 __obsolete_setup("i8042_nomux");

