Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264223AbUEXKBa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264223AbUEXKBa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 06:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264215AbUEXKBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 06:01:30 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:49063 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S264223AbUEXKB2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 06:01:28 -0400
Subject: [PATCH] typo in drivers/usb/class/usblp.c
From: =?ISO-8859-1?Q?Beno=EEt?= Dejean <TazForEver@free.fr>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <40B1BEAC.30500@jp.fujitsu.com>
References: <40B1BEAC.30500@jp.fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1085392887.6815.28.camel@athlon>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.5 
Date: Mon, 24 May 2004 12:01:27 +0200
Content-Transfer-Encoding: 8bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i think there's a typo error in usblp.c

patch against 2.6.6

--- linux-2.6.6/drivers/usb/class/usblp.c	2004-04-04 05:36:26.000000000
+0200
+++ linux-2.6.6-modified/drivers/usb/class/usblp.c	2004-05-24
01:15:20.000000000 +0200
@@ -305,7 +305,7 @@
 
 	if (~status & LP_PERRORP)
 		newerr = 3;
-	if (status & LP_POUTPA)
+	if (~status & LP_POUTPA)
 		newerr = 1;
 	if (~status & LP_PSELECD)
 		newerr = 2;

-- 
Benoît Dejean
JID: TazForEver@jabber.org
http://gdesklets.gnomedesktop.org
http://www.paulla.asso.fr

