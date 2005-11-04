Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161060AbVKDE7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161060AbVKDE7s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 23:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161061AbVKDE7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 23:59:47 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:54737 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S1161060AbVKDE7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 23:59:46 -0500
Message-ID: <436AEAD2.40309@m1k.net>
Date: Fri, 04 Nov 2005 00:00:02 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       Kirk Lapray <kirk.lapray@gmail.com>
Subject: [PATCH 2/3] dvb: nxt200x: Fix typo in Makefile for nxt200x
Content-Type: multipart/mixed;
 boundary="------------010302000708000608030504"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010302000708000608030504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit




--------------010302000708000608030504
Content-Type: text/x-patch;
 name="dvb-nxt200x-fix-makefile.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dvb-nxt200x-fix-makefile.patch"

From: Kirk Lapray <kirk.lapray@gmail.com>

- Fix Typo: Change CONFIG_DVB_NXT2002 to CONFIG_DVB_NXT200X
  for the nxt200x module.

Signed-off-by: Kirk Lapray <kirk.lapray@gmail.com>
Signed-off-by: Michael Krufky <mkrufky@m1k.net>

 drivers/media/dvb/frontends/Makefile |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.14-git5.orig/drivers/media/dvb/frontends/Makefile
+++ linux-2.6.14-git5/drivers/media/dvb/frontends/Makefile
@@ -26,7 +26,7 @@ obj-$(CONFIG_DVB_TDA80XX) += tda80xx.o
 obj-$(CONFIG_DVB_TDA10021) += tda10021.o
 obj-$(CONFIG_DVB_STV0297) += stv0297.o
 obj-$(CONFIG_DVB_NXT2002) += nxt2002.o
-obj-$(CONFIG_DVB_NXT2002) += nxt200x.o
+obj-$(CONFIG_DVB_NXT200X) += nxt200x.o
 obj-$(CONFIG_DVB_OR51211) += or51211.o
 obj-$(CONFIG_DVB_OR51132) += or51132.o
 obj-$(CONFIG_DVB_BCM3510) += bcm3510.o


--------------010302000708000608030504--
