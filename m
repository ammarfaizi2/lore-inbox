Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267840AbUJGTrj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267840AbUJGTrj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 15:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266175AbUJGTrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 15:47:32 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:9451 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267961AbUJGTka (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 15:40:30 -0400
Subject: 2.6.9-rc3-mm3 fails to detect aic7xxx
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
Content-Type: text/plain
Message-Id: <1097178019.24355.39.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 07 Oct 2004 12:40:19 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just booted 2.6.9-rc3-mm3 and got the good ol' 

VFS: Cannot open root device "sda2" or unknown-block(0,0)
Please append a correct "root=" boot option
Kernel panic - not syncing: VFS: Unable to mount root fs on
unknown-block(0,0)

backing out bk-scsi.patch seems to fix it.  I believe this worked in
2.6.9-rc3-mm2.

-- Dave

