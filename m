Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269251AbUI3M6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269251AbUI3M6s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 08:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269252AbUI3M6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 08:58:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:60041 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269251AbUI3M6r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 08:58:47 -0400
Date: Thu, 30 Sep 2004 08:58:18 -0400
From: Alan Cox <alan@redhat.com>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Cc: marcel@holtmann.org
Subject: PATCH: Fix typo in final changes to old i4l tty code
Message-ID: <20040930125818.GA16656@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- drivers/isdn/i4l/isdn_tty.c~	2004-09-30 13:56:48.426953344 +0100
+++ drivers/isdn/i4l/isdn_tty.c	2004-09-30 13:56:48.426953344 +0100
@@ -2673,7 +2673,7 @@
 		if ((info->flags & ISDN_ASYNC_CLOSING) || (!info->tty)) {
 			return;
 		}
-		tty_ldisc_flush(tty);
+		tty_ldisc_flush(info->tty);
 		if ((info->flags & ISDN_ASYNC_CHECK_CD) &&
 		    (!((info->flags & ISDN_ASYNC_CALLOUT_ACTIVE) &&
 		       (info->flags & ISDN_ASYNC_CALLOUT_NOHUP)))) {
