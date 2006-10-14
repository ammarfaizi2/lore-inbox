Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbWJNMK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbWJNMK1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 08:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbWJNMKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 08:10:24 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:11213 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932202AbWJNMII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 08:08:08 -0400
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Hans Verkuil <hverkuil@xs4all.nl>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 15/18] V4L/DVB (4744): The Samsung TCPN2121P30A does not
	have a tda9887
Date: Sat, 14 Oct 2006 09:00:51 -0300
Message-id: <20061014120051.PS51119100015@infradead.org>
In-Reply-To: <20061014115356.PS36551000000@infradead.org>
References: <20061014115356.PS36551000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Hans Verkuil <hverkuil@xs4all.nl>

Contrary to all expections the Samsung TCPN2121P30A tuner does
NOT have a tda9887. Remove the tda9887 flag from the tuner
definition.

Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/tuner-types.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/media/video/tuner-types.c b/drivers/media/video/tuner-types.c
index 8fff642..7816823 100644
--- a/drivers/media/video/tuner-types.c
+++ b/drivers/media/video/tuner-types.c
@@ -1046,7 +1046,6 @@ static struct tuner_params tuner_samsung
 		.type   = TUNER_PARAM_TYPE_NTSC,
 		.ranges = tuner_samsung_tcpn_2121p30a_ntsc_ranges,
 		.count  = ARRAY_SIZE(tuner_samsung_tcpn_2121p30a_ntsc_ranges),
-		.has_tda9887 = 1,
 	},
 };
 

