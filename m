Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261478AbVGGRSS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261478AbVGGRSS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 13:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbVGGRSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 13:18:16 -0400
Received: from mail.sam-solutions.net ([217.21.35.41]:46986 "EHLO
	mail.sam-solutions.net") by vger.kernel.org with ESMTP
	id S261445AbVGGRQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 13:16:35 -0400
Subject: XFS corruption on move from xscale to i686
From: Yura Pakhuchiy <pakhuchi@sam-solutions.net>
Reply-To: Yura Pakhuchiy <pakhuchiy@gmail.com>
To: linux-xfs@oss.sgi.com, xfs-masters@oss.sgi.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: tibor@altlinux.ru, Yura Pakhuchiy <pakhuchiy@gmail.com>
Content-Type: text/plain
Date: Thu, 07 Jul 2005 20:15:52 +0300
Message-Id: <1120756552.5298.10.camel@pc299.sam-solutions.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
X-Spam-Scanned-By: Spamassassin
X-Virus-Scanned-By: AVP Antivirus
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm creadted XFS volume on 2.6.10 linux xscale/iq31244 box, then I
copyied files on it and moved this hard drive to i686 machine. When I
mounted it on i686, I found no files on it. I runned xfs_check, here is
output:

pc299:/home/yura# xfs_check /dev/sda5
dir 128 size is 31, should be 13
dir 128 offsets too high
root directory 128 has .. 0
dir 131 entry  bad inode number 4030121216
dir 131 entry                                      SRPMS.base bad offset 0
dir 131 bad size in entry at 68
link count mismatch for inode 0 (name ?), nlink 0, counted 3
link count mismatch for inode 6303282 (name ?), nlink 0, counted 1
link count mismatch for inode 128 (name ?), nlink 3, counted 1
link count mismatch for inode 131 (name ?), nlink 5, counted 4
link count mismatch for inode 33554560 (name ?), nlink 2, counted 1
link count mismatch for inode 67108992 (name ?), nlink 2, counted 1
link count mismatch for inode 100663424 (name ?), nlink 2, counted 1

-- 
Best regards,
        Yura

