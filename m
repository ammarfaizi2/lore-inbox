Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbVILHvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbVILHvF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 03:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbVILHvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 03:51:05 -0400
Received: from [85.8.12.41] ([85.8.12.41]:8066 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1751208AbVILHvE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 03:51:04 -0400
Message-ID: <4325335D.9010504@drzeus.cx>
Date: Mon, 12 Sep 2005 09:50:53 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.6-5 (X11/20050818)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Remove unused timer.
References: <43249572.7030407@drzeus.cx>
In-Reply-To: <43249572.7030407@drzeus.cx>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove timer that was left from earlier cleanup.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

(obsoletes [PATCH] Remove wbsd delayed detection.)

 drivers/mmc/wbsd.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/wbsd.h b/drivers/mmc/wbsd.h
--- a/drivers/mmc/wbsd.h
+++ b/drivers/mmc/wbsd.h
@@ -184,6 +184,5 @@ struct wbsd_host
 	struct tasklet_struct	finish_tasklet;
 	struct tasklet_struct	block_tasklet;

-	struct timer_list	detect_timer;	/* Card detection timer */
 	struct timer_list	ignore_timer;	/* Ignore detection timer */
 };

