Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267760AbUJOMhM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267760AbUJOMhM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 08:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267772AbUJOMhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 08:37:11 -0400
Received: from holub.nextsoft.cz ([195.122.198.235]:37861 "EHLO
	holub.nextsoft.cz") by vger.kernel.org with ESMTP id S267760AbUJOMfB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 08:35:01 -0400
From: Michal Rokos <michal@rokos.info>
To: linux-kernel@vger.kernel.org
Subject: [Patch 2.6] PCMCIA ds - Exclude uneeded code when ! CONFIG_PROC_FS
Date: Fri, 15 Oct 2004 14:34:58 +0200
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410151434.58571.michal@rokos.info>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

just a oneliner to remove unneeded definition that is done below in the 
code anyway.

Michal

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/10/15 13:28:23+02:00 michal@nb-rokos.nx.cz 
#   proc_pccard is declared below once again, so exclude it here and let 
it be in ifdef CONFIG_PROC_FS block.
# 
# drivers/pcmcia/ds.c
#   2004/10/15 13:28:02+02:00 michal@nb-rokos.nx.cz +0 -2
#   proc_pccard is declared below once again, so exclude it here and let 
it be in ifdef CONFIG_PROC_FS block.
# 
diff -Nru a/drivers/pcmcia/ds.c b/drivers/pcmcia/ds.c
--- a/drivers/pcmcia/ds.c 2004-10-15 14:26:19 +02:00
+++ b/drivers/pcmcia/ds.c 2004-10-15 14:26:19 +02:00
@@ -134,8 +134,6 @@
 
 static int major_dev = -1;
 
-static struct proc_dir_entry *proc_pccard;
-
 /*====================================================================*/
 
 /* code which was in cs.c before */

