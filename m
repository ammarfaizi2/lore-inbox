Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264231AbUEXKLc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264231AbUEXKLc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 06:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264235AbUEXKLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 06:11:32 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:27113 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S264231AbUEXKLb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 06:11:31 -0400
Subject: [PATCH] typo in drivers/usb/class/usblp.c (resend)
From: =?ISO-8859-1?Q?Beno=EEt?= Dejean <TazForEver@free.fr>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Message-Id: <1085393489.6815.30.camel@athlon>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.5 
Date: Mon, 24 May 2004 12:11:29 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i think there's a typo error in usblp.c

patch against 2.6.6

--- linux-2.6.6/drivers/usb/class/usblp.c       2004-04-04
05:36:26.000000000
+0200
+++ linux-2.6.6-modified/drivers/usb/class/usblp.c      2004-05-24
01:15:20.000000000 +0200
@@ -305,7 +305,7 @@
 
        if (~status & LP_PERRORP)
                newerr = 3;
-       if (status & LP_POUTPA)
+       if (~status & LP_POUTPA)
                newerr = 1;
        if (~status & LP_PSELECD)
                newerr = 2;
-- 
Benoît Dejean
JID: TazForEver@jabber.org
http://gdesklets.gnomedesktop.org
http://www.paulla.asso.fr

