Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266885AbUJSTAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266885AbUJSTAp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 15:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269649AbUJSSWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 14:22:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:21393 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S270110AbUJSSAy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 14:00:54 -0400
Date: Tue, 19 Oct 2004 19:00:48 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 1/2: device-mapper trivial: stray semi-colon
Message-ID: <20041019180048.GF6420@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove stray semicolon.

Signed-Off-By: Alasdair G Kergon <agk@redhat.com>
From: Lars Marowsky-Bree <lmb@suse.de>
--- diff/drivers/md/dm.c	2004-10-19 16:56:08.000000000 +0100
+++ source/drivers/md/dm.c	2004-10-19 16:55:56.000000000 +0100
@@ -808,7 +808,7 @@
 {
 	struct mapped_device *md = (struct mapped_device *) context;
 
-	atomic_inc(&md->event_nr);;
+	atomic_inc(&md->event_nr);
 	wake_up(&md->eventq);
 }
 
