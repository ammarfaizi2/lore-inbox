Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261290AbSJHTHk>; Tue, 8 Oct 2002 15:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262760AbSJHTGQ>; Tue, 8 Oct 2002 15:06:16 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:20752 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263207AbSJHTEK>; Tue, 8 Oct 2002 15:04:10 -0400
Subject: PATCH: fix orinoco build
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 8 Oct 2002 20:01:20 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17yzbc-0004tM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/drivers/net/wireless/orinoco_cs.c linux.2.5.41-ac1/drivers/net/wireless/orinoco_cs.c
--- linux.2.5.41/drivers/net/wireless/orinoco_cs.c	2002-10-02 21:34:05.000000000 +0100
+++ linux.2.5.41-ac1/drivers/net/wireless/orinoco_cs.c	2002-10-08 00:11:30.000000000 +0100
@@ -32,7 +32,6 @@
 #include <linux/if_arp.h>
 #include <linux/etherdevice.h>
 #include <linux/wireless.h>
-#include <linux/tqueue.h>
 
 #include <pcmcia/version.h>
 #include <pcmcia/cs_types.h>
