Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbVIEVrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbVIEVrL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 17:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932672AbVIEVno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 17:43:44 -0400
Received: from smtp4.brturbo.com.br ([200.199.201.180]:17746 "EHLO
	smtp4.brturbo.com.br") by vger.kernel.org with ESMTP
	id S932657AbVIEVni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 17:43:38 -0400
Date: Mon, 05 Sep 2005 18:26:15 -0300
From: mchehab@brturbo.com.br
To: linux-kernel@vger.kernel.org
Cc: video4linux-list@redhat.com, akpm@osdl.org
Subject: [PATCH 07/24] V4L: correct LG NTSC TALN mini tuner takeover
Message-ID: <431cb7f7.3S7q6v5bXPnzNHG8%mchehab@brturbo.com.br>
User-Agent: nail 11.25 7/29/05
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_431cb7f7.FnKB6DHhY2X7GzVP3WGV92Np1yKH0qs77ehvxbu7fpAJBTxX"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--=_431cb7f7.FnKB6DHhY2X7GzVP3WGV92Np1yKH0qs77ehvxbu7fpAJBTxX
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

.

--=_431cb7f7.FnKB6DHhY2X7GzVP3WGV92Np1yKH0qs77ehvxbu7fpAJBTxX
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="v4l-07-patch.diff"

- correct LG NTSC TALN mini tuner takeover as far we can
  empirically determine for now.

Signed-off-by: Hermann Pitton <hermann.pitton@onlinehome.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

 linux/drivers/media/video/tuner-simple.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -u /tmp/dst.32131 linux/drivers/media/video/tuner-simple.c
--- /tmp/dst.32131	2005-09-05 11:42:44.000000000 -0300
+++ linux/drivers/media/video/tuner-simple.c	2005-09-05 11:42:44.000000000 -0300
@@ -250,7 +250,7 @@
 	{ "Ymec TVF66T5-B/DFF", Philips, PAL,
           16*160.25,16*464.25,0x01,0x02,0x08,0x8e,623},
  	{ "LG NTSC (TALN mini series)", LGINNOTEK, NTSC,
-	  16*150.00,16*425.00,0x01,0x02,0x08,0x8e,732 },
+	  16*137.25,16*373.25,0x01,0x02,0x08,0x8e,732 },
 };
 
 unsigned const int tuner_count = ARRAY_SIZE(tuners);

--=_431cb7f7.FnKB6DHhY2X7GzVP3WGV92Np1yKH0qs77ehvxbu7fpAJBTxX--
