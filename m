Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261922AbTHYOEL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 10:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbTHYOEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 10:04:11 -0400
Received: from verein.lst.de ([212.34.189.10]:31133 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261922AbTHYOEG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 10:04:06 -0400
Date: Mon, 25 Aug 2003 16:03:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: marcelo@hera.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] reserve a sysctl number for XFS (pagebuf)
Message-ID: <20030825140316.GA17269@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, marcelo@hera.kernel.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -3 () PATCH_UNIFIED_DIFF,USER_AGENT_MUTT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reserve the 2.5 number for VM_PAGEBUF in 2.4 aswell.


--- 1.27/include/linux/sysctl.h	Tue Jun 24 17:11:29 2003
+++ edited/include/linux/sysctl.h	Mon Aug 25 14:06:01 2003
@@ -146,6 +146,7 @@
 	VM_MAX_MAP_COUNT=11,	/* int: Maximum number of active map areas */
 	VM_MIN_READAHEAD=12,    /* Min file readahead */
 	VM_MAX_READAHEAD=13,    /* Max file readahead */
+	VM_PAGEBUF=17,		/* struct: Control pagebuf parameters */
 };
 
 
