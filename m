Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262622AbVDYO4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262622AbVDYO4l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 10:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262624AbVDYO4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 10:56:41 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:37589 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262622AbVDYO4k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 10:56:40 -0400
Subject: Re: [PATCH] JFS fsync wrong behavior when I/O failure occurs
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: qufuping <qufuping@ercist.iscas.ac.cn>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       okuyama@intellilink.co.jp, kuroiwaj@intellilink.co.jp,
       xuh@nttdata.com.cn,
       JFS Discussion <jfs-discussion@lists.sourceforge.net>
In-Reply-To: <004301c549a4$2d1d3440$dd024dd2@coolq>
References: <004301c549a4$2d1d3440$dd024dd2@coolq>
Content-Type: text/plain
Date: Mon, 25 Apr 2005 09:56:11 -0500
Message-Id: <1114440971.19089.7.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-25 at 22:36 +0800, qufuping wrote:
> JFS contains a bug with sys_fsync(jfs_fsync), also with fs/mpage.c:mpage_end_io_write

ACK.  This patch looks good to me.

Thanks,
Shaggy

> Symptom
> The open-write-fsync-close code will not return error when disk I/O occurs
> between open and fsync.
-- 
David Kleikamp
IBM Linux Technology Center

