Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965089AbWCTQWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965089AbWCTQWz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 11:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965091AbWCTQWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 11:22:55 -0500
Received: from ftp.linux-mips.org ([194.74.144.162]:19884 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S965089AbWCTQWx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 11:22:53 -0500
Date: Mon, 20 Mar 2006 16:22:02 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] EISA: Ignore generated file drivers/eisa/devlist.h.
Message-ID: <20060320162202.GA16436@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/drivers/eisa/.gitignore b/drivers/eisa/.gitignore
new file mode 100644
index 0000000..4b335c0
--- /dev/null
+++ b/drivers/eisa/.gitignore
@@ -0,0 +1 @@
+devlist.h

