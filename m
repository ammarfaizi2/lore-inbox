Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422723AbWA1COc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422723AbWA1COc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 21:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422791AbWA1COc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 21:14:32 -0500
Received: from mx1a.costco.com ([170.167.3.101]:50330 "EHLO mx1a.costco.com")
	by vger.kernel.org with ESMTP id S1422723AbWA1COb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 21:14:31 -0500
Message-ID: <C8172C455C579E448DD354B66AEC23A007E2F68E@pof00099p06.corp.costco.com>
From: Michael Owen <mowen@costco.com>
To: linux-kernel@vger.kernel.org
Subject: typo patch for fs/ufs/super.c
Date: Fri, 27 Jan 2006 18:12:05 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2658.3)
Content-Type: text/plain;
	charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quick and simple typo fix. neTXstep -> neXTstep
--------


--- linux-2.6.15/fs/ufs/super.c 2006-01-02 19:21:10.000000000 -0800
+++ linux-2.6.15-mowen/fs/ufs/super.c   2006-01-27 18:04:17.586215000 -0800
@@ -575,7 +575,7 @@
                if (!silent)
                        printk("You didn't specify the type of your ufs
filesystem\n\n"
                        "mount -t ufs -o ufstype="
-
"sun|sunx86|44bsd|ufs2|5xbsd|old|hp|nextstep|netxstep-cd|openstep ...\n\n"
+
"sun|sunx86|44bsd|ufs2|5xbsd|old|hp|nextstep|nextstep-cd|openstep ...\n\n"
                        ">>>WARNING<<< Wrong ufstype may corrupt your
filesystem, "
                        "default is ufstype=old\n");
                ufs_set_opt (sbi->s_mount_opt, UFSTYPE_OLD);


