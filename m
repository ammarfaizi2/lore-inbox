Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261518AbTAQVjO>; Fri, 17 Jan 2003 16:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261594AbTAQVjN>; Fri, 17 Jan 2003 16:39:13 -0500
Received: from air-2.osdl.org ([65.172.181.6]:37250 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S261518AbTAQVjM>;
	Fri, 17 Jan 2003 16:39:12 -0500
Date: Fri, 17 Jan 2003 13:48:04 -0800
From: Bob Miller <rem@osdl.org>
To: owner-xfs@oss.sgi.com
Cc: trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: [Trivial 2.5.58] Remove compile warning from fs/xfs/support/move.c
Message-ID: <20030117214804.GB22540@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Include string.h to remove a compiler warning.

diff -Nru a/fs/xfs/support/move.c b/fs/xfs/support/move.c
--- a/fs/xfs/support/move.c	Thu Jan 16 14:06:04 2003
+++ b/fs/xfs/support/move.c	Thu Jan 16 14:06:04 2003
@@ -30,6 +30,7 @@
  * http://oss.sgi.com/projects/GenInfo/SGIGPLNoticeExplan/
  */
 
+#include <linux/string.h>
 #include <linux/errno.h>
 #include <asm/uaccess.h>
 
-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17
