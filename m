Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262773AbUCPP3Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 10:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbUCPOkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 09:40:10 -0500
Received: from styx.suse.cz ([82.208.2.94]:62081 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S261918AbUCPOTm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 09:19:42 -0500
Content-Transfer-Encoding: 7BIT
Message-Id: <10794467772420@twilight.ucw.cz>
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 15/44] Add serio entries for LK keyboards.
X-Mailer: gregkh_patchbomb_levon_offspring
To: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Date: Tue, 16 Mar 2004 15:19:37 +0100
In-Reply-To: <10794467774130@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1608.37.15, 2004-03-02 13:47:14+01:00, jbglaw@lug-owl.de
  input: Add serio entries for LK keyboards.


 serio.h |    2 ++
 1 files changed, 2 insertions(+)

===================================================================

diff -Nru a/include/linux/serio.h b/include/linux/serio.h
--- a/include/linux/serio.h	Tue Mar 16 13:19:14 2004
+++ b/include/linux/serio.h	Tue Mar 16 13:19:14 2004
@@ -117,6 +117,7 @@
 #define SERIO_MZ	0x05
 #define SERIO_MZP	0x06
 #define SERIO_MZPP	0x07
+#define SERIO_VSXXXAA	0x08
 #define SERIO_SUNKBD	0x10
 #define SERIO_WARRIOR	0x18
 #define SERIO_SPACEORB	0x19
@@ -134,6 +135,7 @@
 #define SERIO_HIL	0x25
 #define SERIO_SNES232	0x26
 #define SERIO_SEMTECH	0x27
+#define SERIO_LKKBD	0x28
 
 #define SERIO_ID	0xff00UL
 #define SERIO_EXTRA	0xff0000UL

