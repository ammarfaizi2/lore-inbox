Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262606AbVBBUTH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262606AbVBBUTH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 15:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262710AbVBBUKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 15:10:47 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:31620 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S262578AbVBBTqi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 14:46:38 -0500
Subject: [PATCH 2/4] Document the atkbd.softraw module parameter.
In-Reply-To: <11073736133233@twilight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Wed, 2 Feb 2005 20:46:53 +0100
Message-Id: <1107373613347@twilight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/for-linus

===================================================================

ChangeSet@1.1977.1.2, 2005-01-29 12:27:56+01:00, Andries.Brouwer@cwi.nl
  input: Document the atkbd.softraw module parameter.
  
  From: Andries Brouwer <Andries.Brouwer@cwi.nl>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>


 kernel-parameters.txt |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

===================================================================

diff -Nru a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
--- a/Documentation/kernel-parameters.txt	2005-02-02 20:29:48 +01:00
+++ b/Documentation/kernel-parameters.txt	2005-02-02 20:29:48 +01:00
@@ -226,15 +226,19 @@
 
 	atascsi=	[HW,SCSI] Atari SCSI
 
-	atkbd.extra=	[HW] Enable extra LEDs and keys on IBM RapidAccess, EzKey
-			and similar keyboards
+	atkbd.extra=	[HW] Enable extra LEDs and keys on IBM RapidAccess,
+			EzKey and similar keyboards
 
 	atkbd.reset=	[HW] Reset keyboard during initialization
 
 	atkbd.set=	[HW] Select keyboard code set 
 			Format: <int> (2 = AT (default) 3 = PS/2)
 
-	atkbd.scroll=	[HW] Enable scroll wheel on MS Office and similar keyboards
+	atkbd.scroll=	[HW] Enable scroll wheel on MS Office and similar
+			keyboards
+
+	atkbd.softraw=	[HW] Choose between synthetic and real raw mode
+			Format: <bool> (0 = real, 1 = synthetic (default))
 	
 	atkbd.softrepeat=
 			[HW] Use software keyboard repeat

