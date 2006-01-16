Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbWAPJZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbWAPJZH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 04:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbWAPJYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 04:24:47 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:57579 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932279AbWAPJYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 04:24:12 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org, Michael Krufky <mkrufky@m1k.net>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 09/25] disable all dvb tuner param_types until we need them
Date: Mon, 16 Jan 2006 07:11:21 -0200
Message-id: <20060116091121.PS27979800009@infradead.org>
In-Reply-To: <20060116091105.PS83611600000@infradead.org>
References: <20060116091105.PS83611600000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Michael Krufky <mkrufky@m1k.net>

- Add param_type dvbs2
- disable all dvb param_types, which will not
  be needed until we merge dvb-pll.

Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 include/media/tuner-types.h |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/include/media/tuner-types.h b/include/media/tuner-types.h
index 9f6e4a9..64b16b1 100644
--- a/include/media/tuner-types.h
+++ b/include/media/tuner-types.h
@@ -9,11 +9,7 @@ enum param_type {
 	TUNER_PARAM_TYPE_RADIO, \
 	TUNER_PARAM_TYPE_PAL, \
 	TUNER_PARAM_TYPE_SECAM, \
-	TUNER_PARAM_TYPE_NTSC, \
-	TUNER_PARAM_TYPE_ATSC, \
-	TUNER_PARAM_TYPE_DVBT, \
-	TUNER_PARAM_TYPE_DVBS, \
-	TUNER_PARAM_TYPE_DVBC
+	TUNER_PARAM_TYPE_NTSC
 };
 
 struct tuner_range {

