Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262273AbUKDQCd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbUKDQCd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 11:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262274AbUKDQCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 11:02:32 -0500
Received: from alog0450.analogic.com ([208.224.222.226]:1152 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262273AbUKDQBf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 11:01:35 -0500
Date: Thu, 4 Nov 2004 11:01:28 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Linux-2.6.9 won't allow a write to a NTFS file-system.
Message-ID: <Pine.LNX.4.61.0411041054370.4818@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello anybody maintaining NTFS,

I can't write to a NTFS file-system.

/proc/mounts shows it's mounted RW:
/dev/sdd1 /mnt ntfs rw,uid=0,gid=0,fmask=0177,dmask=077,nls=utf8,errors=continue,mft_zone_multiplier=1 0 0

.config shows RW support.

CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=y

Errno is 1 (Operation not permitted), even though root.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
