Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272615AbTHKOGj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 10:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272627AbTHKNmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 09:42:33 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:38795 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S272616AbTHKNlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 09:41:04 -0400
To: torvalds@transmeta.com
From: davej@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] document easier bitkeeper option.
Message-Id: <E19mCuO-0003d3-00@tetrachloride>
Date: Mon, 11 Aug 2003 14:40:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Achieves the same result.  From Lenz Grimmer at Mysql AG

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/Documentation/BK-usage/bk-kernel-howto.txt linux-2.5/Documentation/BK-usage/bk-kernel-howto.txt
--- bk-linus/Documentation/BK-usage/bk-kernel-howto.txt	2003-05-11 22:59:28.000000000 +0100
+++ linux-2.5/Documentation/BK-usage/bk-kernel-howto.txt	2003-05-29 14:07:45.000000000 +0100
@@ -216,7 +216,7 @@ changes.
 
 3) Include a summary and "diffstat -p1" of each changeset that will be
 downloaded, when Linus issues a "bk pull".  The author auto-generates
-these summaries using "bk push -nl <parent> 2>&1", to obtain a listing
+these summaries using "bk changes -L <parent>", to obtain a listing
 of all the pending-to-send changesets, and their commit messages.
 
 It is important to show Linus what he will be downloading when he issues
