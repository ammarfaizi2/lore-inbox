Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261814AbVCUPzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261814AbVCUPzn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 10:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbVCUPzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 10:55:43 -0500
Received: from ns3.dataphone.se ([212.37.0.170]:11986 "EHLO
	mail-slave.dataphone.se") by vger.kernel.org with ESMTP
	id S261814AbVCUPzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 10:55:38 -0500
From: Magnus Damm <damm@opensource.se>
To: linux-kernel@vger.kernel.org
Cc: Magnus Damm <damm@opensource.se>
Message-Id: <20050321152735.19016.79587.32236@clementine.local>
Subject: [PATCH] cifs: MODULE_PARM_DESC
Date: Mon, 21 Mar 2005 16:55:37 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix parameter description typo, use parameter name "cifs_min_small" instead of
non-existing "cifs_small_rcv" for MODULE_PARM_DESC.

Error detected with section2text.rb, see autoparam patch. 

Signed-off-by: Magnus Damm <damm@opensource.se>

--- linux-2.6.12-rc1/fs/cifs/cifsfs.c	2005-03-20 18:20:17.000000000 +0100
+++ linux-2.6.12-rc1-autoparam/fs/cifs/cifsfs.c	2005-03-21 15:57:28.000000000 +0100
@@ -66,7 +66,7 @@
 MODULE_PARM_DESC(cifs_min_rcv,"Network buffers in pool. Default: 4 Range: 1 to 64");
 unsigned int cifs_min_small = 30;
 module_param(cifs_min_small, int, 0);
-MODULE_PARM_DESC(cifs_small_rcv,"Small network buffers in pool. Default: 30 Range: 2 to 256");
+MODULE_PARM_DESC(cifs_min_small,"Small network buffers in pool. Default: 30 Range: 2 to 256");
 unsigned int cifs_max_pending = CIFS_MAX_REQ;
 module_param(cifs_max_pending, int, 0);
 MODULE_PARM_DESC(cifs_max_pending,"Simultaneous requests to server. Default: 50 Range: 2 to 256");
