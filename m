Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265520AbTFWVPT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 17:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265521AbTFWVPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 17:15:19 -0400
Received: from air-2.osdl.org ([65.172.181.6]:60564 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265520AbTFWVNW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 17:13:22 -0400
Date: Mon, 23 Jun 2003 14:28:09 -0700
From: Dave Olien <dmo@osdl.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] minor sparse change fixing a typo
Message-ID: <20030623212809.GA25219@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch fixes a one-character typo in evaluating SPECIAL_OR_ASSIGN.

--- sparse_original/evaluate.c	2003-06-16 08:25:48.000000000 -0700
+++ sparse_test/evaluate.c	2003-06-23 14:21:19.000000000 -0700
@@ -848,7 +848,7 @@
 		[SPECIAL_SHL_ASSIGN - SPECIAL_BASE] = SPECIAL_LEFTSHIFT,
 		[SPECIAL_SHR_ASSIGN - SPECIAL_BASE] = SPECIAL_RIGHTSHIFT,
 		[SPECIAL_AND_ASSIGN - SPECIAL_BASE] = '&',
-		[SPECIAL_OR_ASSIGN - SPECIAL_BASE] = '&',
+		[SPECIAL_OR_ASSIGN - SPECIAL_BASE] = '|',
 		[SPECIAL_XOR_ASSIGN - SPECIAL_BASE] = '^'
 	};
 
