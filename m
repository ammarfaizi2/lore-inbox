Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbTJMQWn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 12:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbTJMQWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 12:22:43 -0400
Received: from imladris.surriel.com ([66.92.77.98]:20160 "EHLO
	imladris.surriel.com") by vger.kernel.org with ESMTP
	id S261943AbTJMQWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 12:22:42 -0400
Date: Mon, 13 Oct 2003 12:22:21 -0400 (EDT)
From: Rik van Riel <riel@surriel.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][TRIVIAL] initialise variables in SiS_GetCRT2Data301()
Message-ID: <Pine.LNX.4.55L.0310131221550.27244@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urNp linux-5110/drivers/video/sis/init301.c linux-10010/drivers/video/sis/init301.c
--- linux-5110/drivers/video/sis/init301.c
+++ linux-10010/drivers/video/sis/init301.c
@@ -2983,7 +2983,7 @@ SiS_GetCRT2Data301(SiS_Private *SiS_Pr,
                    USHORT RefreshRateTableIndex,
 		   PSIS_HW_DEVICE_INFO HwDeviceExtension)
 {
-  USHORT tempax,tempbx,modeflag;
+  USHORT tempax=0,tempbx=0,modeflag;
   USHORT resinfo;
   USHORT CRT2Index,ResIndex;
   const SiS_LCDDataStruct *LCDPtr = NULL;
