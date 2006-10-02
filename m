Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932613AbWJBFFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932613AbWJBFFa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 01:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932618AbWJBFF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 01:05:29 -0400
Received: from havoc.gtf.org ([69.61.125.42]:30869 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932613AbWJBFF2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 01:05:28 -0400
Date: Mon, 2 Oct 2006 01:05:28 -0400
From: Jeff Garzik <jeff@garzik.org>
To: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-tape@vger.kernel.org
Subject: [PATCH] schedule ftape removal
Message-ID: <20061002050528.GA10288@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index 9364f47..57e72e6 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -325,3 +325,11 @@ Why:	i2c-isa is a non-sense and doesn't 
 Who:	Jean Delvare <khali@linux-fr.org>
 
 ---------------------------
+
+What:	ftape
+When:	2.6.20
+Why:	Orphaned for ages.  SMP bugs long unfixed.  Few users left
+	in the world.
+Who:	Jeff Garzik <jeff@garzik.org>
+
+---------------------------
