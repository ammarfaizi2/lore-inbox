Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750982AbVILOUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbVILOUt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 10:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbVILOUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 10:20:48 -0400
Received: from [85.8.12.41] ([85.8.12.41]:26754 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1750980AbVILOUs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 10:20:48 -0400
Message-ID: <43258EB8.2010302@drzeus.cx>
Date: Mon, 12 Sep 2005 16:20:40 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.6-5 (X11/20050818)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hermes.drzeus.cx-10711-1126534847-0001-2"
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove unused timer.
References: <43249572.7030407@drzeus.cx> <4325335D.9010504@drzeus.cx>
In-Reply-To: <4325335D.9010504@drzeus.cx>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hermes.drzeus.cx-10711-1126534847-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

Pierre Ossman wrote:
> Remove timer that was left from earlier cleanup.
> 
> Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
> ---

Resend with attachment.

--=_hermes.drzeus.cx-10711-1126534847-0001-2
Content-Type: text/x-patch; name="wbsd-no-detect-timer.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="wbsd-no-detect-timer.patch"

Remove unused timer.

Remove timer that was left from earlier cleanup.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

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

--=_hermes.drzeus.cx-10711-1126534847-0001-2--
