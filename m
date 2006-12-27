Return-Path: <linux-kernel-owner+w=401wt.eu-S933002AbWL0RLz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933002AbWL0RLz (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 12:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932933AbWL0RLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 12:11:34 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41445 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932996AbWL0RKt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 12:10:49 -0500
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: V4L-DVB Maintainers <v4l-dvb-maintainer@linuxtv.org>,
       Hans Verkuil <hverkuil@xs4all.nl>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 17/28] V4L/DVB (4988): Cx2341x audio_properties is an u16,
	not u8
Date: Wed, 27 Dec 2006 14:57:30 -0200
Message-id: <20061227165730.PS57436900017@infradead.org>
In-Reply-To: <20061227165016.PS89442900000@infradead.org>
References: <20061227165016.PS89442900000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Hans Verkuil <hverkuil@xs4all.nl>

This bug broke the MPEG audio mode controls.

Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 include/media/cx2341x.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/media/cx2341x.h b/include/media/cx2341x.h
index d91d88f..ecad55b 100644
--- a/include/media/cx2341x.h
+++ b/include/media/cx2341x.h
@@ -49,7 +49,7 @@ struct cx2341x_mpeg_params {
 	enum v4l2_mpeg_audio_mode_extension audio_mode_extension;
 	enum v4l2_mpeg_audio_emphasis audio_emphasis;
 	enum v4l2_mpeg_audio_crc audio_crc;
-	u8 audio_properties;
+	u16 audio_properties;
 
 	/* video */
 	enum v4l2_mpeg_video_encoding video_encoding;

