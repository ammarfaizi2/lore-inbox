Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752411AbVHHAzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752411AbVHHAzQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 20:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753171AbVHHAzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 20:55:16 -0400
Received: from hulk.hostingexpert.com ([69.57.134.39]:34917 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S1752411AbVHHAzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 20:55:15 -0400
Message-ID: <42F6AD79.7050107@m1k.net>
Date: Sun, 07 Aug 2005 20:55:21 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: LKML <linux-kernel@vger.kernel.org>, linux-dvb-maintainer@linuxtv.org,
       Mac Michaels <wmichaels1@earthlink.net>
Subject: [PATCH] DVB: lgdt330x frontend: trivial text cleanups
References: <42F6A294.90300@linuxtv.org>
In-Reply-To: <42F6A294.90300@linuxtv.org>
Content-Type: multipart/mixed;
 boundary="------------010301050609000203000207"
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
--------------010301050609000203000207
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

some tiny minor cleanups...

-- 
Michael Krufky





--------------010301050609000203000207
Content-Type: text/plain;
 name="lgdt330x-trivial-text.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lgdt330x-trivial-text.patch"

Two trivial text changes in Kconfig and lgdt330x.c

Signed-off-by: Michael Krufky <mkrufky@m1k.net>

 linux/drivers/media/dvb/frontends/Kconfig    |    2 +-
 linux/drivers/media/dvb/frontends/lgdt330x.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -u linux-2.6.13/drivers/media/dvb/frontends/lgdt330x.c linux/drivers/media/dvb/frontends/lgdt330x.c
--- linux-2.6.13/drivers/media/dvb/frontends/lgdt330x.c	2005-08-07 18:49:20.000000000 +0000
+++ linux/drivers/media/dvb/frontends/lgdt330x.c	2005-08-07 20:49:18.000000000 +0000
@@ -772,7 +772,7 @@
 
 static struct dvb_frontend_ops lgdt3302_ops = {
 	.info = {
-		.name= "LG Electronics LGDT3302/LGDT3303 VSB/QAM Frontend",
+		.name= "LG Electronics LGDT3302 VSB/QAM Frontend",
 		.type = FE_ATSC,
 		.frequency_min= 54000000,
 		.frequency_max= 858000000,
diff -u linux-2.6.13/drivers/media/dvb/frontends/Kconfig linux/drivers/media/dvb/frontends/Kconfig
--- linux-2.6.13/drivers/media/dvb/frontends/Kconfig	2005-08-07 15:36:35.000000000 +0000
+++ linux/drivers/media/dvb/frontends/Kconfig	2005-08-07 20:49:18.000000000 +0000
@@ -188,7 +188,7 @@
 	  support this frontend.
 
 config DVB_LGDT330X
-	tristate "LGDT3302 or LGDT3303 based (DViCO FusionHDTV Gold)"
+	tristate "LG Electronics LGDT3302/LGDT3303 based"
 	depends on DVB_CORE
 	help
 	  An ATSC 8VSB and QAM64/256 tuner module. Say Y when you want

--------------010301050609000203000207--
