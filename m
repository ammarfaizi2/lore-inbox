Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbTISK2b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 06:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbTISK1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 06:27:00 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:19598 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261487AbTISK0w convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 06:26:52 -0400
Subject: [PATCH 6/11] input: Change name of Synaptics protocol to SynPS/2
In-Reply-To: <10639672012942@twilight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Fri, 19 Sep 2003 12:26:41 +0200
Message-Id: <10639672011502@twilight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1344, 2003-09-19 01:19:41-07:00, vojtech@suse.cz
  psmouse-base.c:
    Change the name od the Synaptics protocol to SynPS/2


 psmouse-base.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

===================================================================

diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	Fri Sep 19 12:16:16 2003
+++ b/drivers/input/mouse/psmouse-base.c	Fri Sep 19 12:16:16 2003
@@ -41,7 +41,7 @@
 int psmouse_smartscroll = PSMOUSE_LOGITECH_SMARTSCROLL;
 unsigned int psmouse_resetafter;
 
-static char *psmouse_protocols[] = { "None", "PS/2", "PS2++", "PS2T++", "GenPS/2", "ImPS/2", "ImExPS/2", "Synaptics"};
+static char *psmouse_protocols[] = { "None", "PS/2", "PS2++", "PS2T++", "GenPS/2", "ImPS/2", "ImExPS/2", "SynPS/2"};
 
 /*
  * psmouse_process_packet() analyzes the PS/2 mouse packet contents and

