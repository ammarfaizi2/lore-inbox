Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932678AbVIEVnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932678AbVIEVnl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 17:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932672AbVIEVnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 17:43:40 -0400
Received: from smtp4.brturbo.com.br ([200.199.201.180]:18002 "EHLO
	smtp4.brturbo.com.br") by vger.kernel.org with ESMTP
	id S932654AbVIEVni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 17:43:38 -0400
Date: Mon, 05 Sep 2005 18:26:16 -0300
From: mchehab@brturbo.com.br
To: linux-kernel@vger.kernel.org
Cc: video4linux-list@redhat.com, akpm@osdl.org
Subject: [PATCH 19/24] V4L: correct the amux for composite and s-video
 inputs on the Sabrent SBT-TVFM card.
Message-ID: <431cb7f8.t1X7pvNVWxJ9oGaq%mchehab@brturbo.com.br>
User-Agent: nail 11.25 7/29/05
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_431cb7f8.NzF7KlW2KdmVksBgHSuKL9QIQVr2BaM8vsIqA3mvf/L6uxAY"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--=_431cb7f8.NzF7KlW2KdmVksBgHSuKL9QIQVr2BaM8vsIqA3mvf/L6uxAY
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

.

--=_431cb7f8.NzF7KlW2KdmVksBgHSuKL9QIQVr2BaM8vsIqA3mvf/L6uxAY
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="v4l-19-patch.diff"

- correct the amux for composite and s-video inputs on the Sabrent SBT-TVFM card.

Signed-off-by: Michael Rodriquez-Torrent <mike@themikecam.com>
Signed-off-by: Michael Krufky <mkrufky@m1k.net>

 linux/drivers/media/video/saa7134/saa7134-cards.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -u /tmp/dst.902 linux/drivers/media/video/saa7134/saa7134-cards.c
--- /tmp/dst.902	2005-09-05 11:43:12.000000000 -0300
+++ linux/drivers/media/video/saa7134/saa7134-cards.c	2005-09-05 11:43:12.000000000 -0300
@@ -1372,7 +1372,7 @@
 		.inputs         = {{
 			.name = name_comp1,
 			.vmux = 1,
-			.amux = LINE2,
+			.amux = LINE1,
 		},{
 			.name = name_tv,
 			.vmux = 3,
@@ -1381,7 +1381,7 @@
 		},{
 			.name = name_svideo,
 			.vmux = 8,
-			.amux = LINE2,
+			.amux = LINE1,
 		}},
 		.radio = {
 			.name   = name_radio,

--=_431cb7f8.NzF7KlW2KdmVksBgHSuKL9QIQVr2BaM8vsIqA3mvf/L6uxAY--
