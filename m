Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263942AbUASW5o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 17:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264941AbUASW5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 17:57:44 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:18100 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S263942AbUASW5j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 17:57:39 -0500
Date: Mon, 19 Jan 2004 14:57:27 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Cc: admin@kornet.net, postmaster@kornet.net, abuse@kornet.net
Subject: Fwd: [ERR] [2.6][smbfs] smb_open & smb_readpage_sync errors in kernel log
Message-ID: <20040119225727.GU8664@srv-lnx2600.matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, admin@kornet.net,
	postmaster@kornet.net, abuse@kornet.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like someone has misconfigured this mail server...

It shouldn't be bouncing to everyone sending to the list, and the mailserver
should be looking at the Return-path: header.

----- Forwarded message from postmaster@kornet.net -----

Delivery-date: Mon, 19 Jan 2004 14:50:52 -0800
Auto-Submitted: auto-generated
Date: Tue, 20 Jan 2004 07:51:05 +0900
From: postmaster@kornet.net
To: mfedyk@matchmail.com
Subject: [ERR] [2.6][smbfs] smb_open & smb_readpage_sync errors in kernel log
X-MsgID: 1074552665755977959.0.ppp15
X-Spam-DCC: : 
X-Spam-Checker-Version: SpamAssassin 2.61 (1.212.2.1-2003-12-09-exp) on 
	fileserver.matchmail.com
X-Spam-Level: 
X-Spam-Status: No, hits=-4.7 required=7.0 tests=BAYES_00,NO_REAL_NAME 
	autolearn=no version=2.61

Transmit Report:

 To: pupuru@kornet.net, 452 Requested action not taken: insufficient system storage.[28,-1,41]

X-MsgID: 1074552665511616396.0.ppp15
Date:	Mon, 19 Jan 2004 10:44:35 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: [2.6][smbfs] smb_open & smb_readpage_sync errors in kernel log
Y-Message-ID: <20040119184435.GT8664@srv-lnx2600.matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
User-Agent: Mutt/1.5.4i
X-Mailing-List:	linux-kernel@vger.kernel.org

I've been getting these error messages in my kernel forever, I think even
with 2.2 kernels, and it's still there in 2.6:

smb_open: config/SAM open failed, result=-26
smb_readpage_sync: config/SAM open failed, error=-26

It does this for several locked system files on the windows machines.

This happens during a find command run on the mounted share from one of my
scripts that compares file dates.

Can these printk calls be removed?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



----- End forwarded message -----
