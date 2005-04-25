Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262754AbVDYTKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262754AbVDYTKM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 15:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262755AbVDYTJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 15:09:34 -0400
Received: from smtp.nildram.co.uk ([195.112.4.54]:65298 "EHLO
	smtp.nildram.co.uk") by vger.kernel.org with ESMTP id S262744AbVDYTHU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 15:07:20 -0400
From: Pete Jewell <pete@phraxos.nildram.co.uk>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix for bttv driver (v0.9.15) for Leadtek WinFast VC100 XP capture cards
Date: Mon, 25 Apr 2005 20:07:14 +0100
User-Agent: KMail/1.8
x-gazette-tag: PeteJ
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_j/TbCXqfLlwDW5F"
Message-Id: <200504252007.15329.pete@phraxos.nildram.co.uk>
X-AV-Checked: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_j/TbCXqfLlwDW5F
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi

This is a tiny patch that fixes bttv-cards.c so that Leadtek WinFast VC100 
XP video capture cards work.  I've been advised to post it here after 
having already posted it to the v4l mailing list.

Thanks.

-- 
Pete

--Boundary-00=_j/TbCXqfLlwDW5F
Content-Type: text/x-diff;
  charset="us-ascii";
  name="bttv-cards.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="bttv-cards.patch"

--- bttv-cards.c	2005-04-24 23:39:41.000000000 +0100
+++ /usr/src/kernel-source-2.6.11/drivers/media/video/bttv-cards.c	2005-04-25 19:59:27.000000000 +0100
@@ -1939,7 +1939,6 @@
         .no_tda9875     = 1,
         .no_tda7432     = 1,
         .tuner_type     = TUNER_ABSENT,
-        .no_video       = 1,
 	.pll            = PLL_28,
 },{
 	.name           = "Teppro TEV-560/InterVision IV-560",

--Boundary-00=_j/TbCXqfLlwDW5F--
