Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266648AbUGVAFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266648AbUGVAFY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 20:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266781AbUGVAFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 20:05:24 -0400
Received: from ishtar.tlinx.org ([64.81.245.74]:59021 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S266648AbUGVAFP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 20:05:15 -0400
Message-ID: <40FF0479.6050509@tlinx.org>
Date: Wed, 21 Jul 2004 17:04:09 -0700
From: L A Walsh <lkml@tlinx.org>
User-Agent: Mozilla Thunderbird 0.7.1 (Windows/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
CC: linux-xfs@oss.sgi.com
Subject: 2.6.7-vanilla-SMP kernel: pagebuf_get: failed to lookup pages
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jul 20 09:07:34 ishtar kernel: pagebuf_get: failed to lookup pages
Jul 20 09:07:34 ishtar last message repeated 25 times
Jul 20 09:26:38 ishtar kernel: pagebuf_get: failed to lookup pages
Jul 20 09:27:09 ishtar last message repeated 354 times
Jul 20 09:27:52 ishtar last message repeated 274 times
Jul 20 09:45:46 ishtar kernel: pagebuf_get: failed to lookup pages
Jul 20 09:45:46 ishtar last message repeated 2 times
Jul 20 10:00:10 ishtar kernel: pagebuf_get: failed to lookup pages
Jul 21 02:30:00 ishtar su: (to backup) root on none
Jul 21 02:30:01 ishtar kernel: pagebuf_get: failed to lookup pages
Jul 21 02:30:04 ishtar last message repeated 16 times
Jul 21 02:30:30 ishtar su: (to backup) root on none
Jul 21 02:31:55 ishtar su: (to backup) root on none
Jul 21 02:31:55 ishtar last message repeated 3 times
Jul 21 03:15:09 ishtar kernel: pagebuf_get: failed to lookup pages
Jul 21 03:15:09 ishtar last message repeated 4 times
Jul 21 04:07:34 ishtar kernel: pagebuf_get: failed to lookup pages
Jul 21 04:07:34 ishtar last message repeated 9 times
Jul 21 04:26:44 ishtar kernel: pagebuf_get: failed to lookup pages
Jul 21 04:27:45 ishtar last message repeated 1516 times
Jul 21 04:27:54 ishtar last message repeated 36 times
Jul 21 04:45:51 ishtar kernel: pagebuf_get: failed to lookup pages
Jul 21 04:45:51 ishtar last message repeated 7 times

----

    Any idea what this message means?  I especially notice a high 
frequency during
high disk i/o.  File systems are all xfs if that is pertinent.  Backups 
run in early
AM backing up SCSI disks to a large IDE.  However, the messages around 
9:27 on the
20th wouldn't have been backup related but possibly processing a backlog of
email after some system maintenance -- and that would have all been on 
SCSI disks.


