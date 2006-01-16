Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932297AbWAPJ2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbWAPJ2V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 04:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbWAPJX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 04:23:58 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:51691 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932268AbWAPJXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 04:23:52 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org, Michael Krufky <mkrufky@m1k.net>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 22/25] clean up some comments
Date: Mon, 16 Jan 2006 07:11:25 -0200
Message-id: <20060116091125.PS22619100022@infradead.org>
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

- clean up some comments

Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 include/media/tuner-types.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/include/media/tuner-types.h b/include/media/tuner-types.h
index b37d59d..9f0e9c1 100644
--- a/include/media/tuner-types.h
+++ b/include/media/tuner-types.h
@@ -31,7 +31,8 @@ struct tuner_params {
 	 *   will result in very low tuning voltage which may drive the
 	 *   oscillator to extreme conditions.
 	 *
-	 * Set this flag to 1 if this tuner needs this check.
+	 * Set cb_first_if_lower_freq to 1, if this check is 
+	 * required for this tuner.
 	 *
 	 * I tested this for PAL by first setting the TV frequency to
 	 * 203 MHz and then switching to 96.6 MHz FM radio. The result was

