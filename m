Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbVLKPX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbVLKPX5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 10:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbVLKPX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 10:23:57 -0500
Received: from host94-205.pool8022.interbusiness.it ([80.22.205.94]:42897 "EHLO
	waobagger.intranet.nucleus.it") by vger.kernel.org with ESMTP
	id S1750714AbVLKPX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 10:23:56 -0500
From: Massimiliano Hofer <max@bbs.cc.uniud.it>
Organization: Nucleus snc
To: linux-kernel@vger.kernel.org
Subject: freeze with IDE
Date: Sun, 11 Dec 2005 16:23:35 +0100
User-Agent: KMail/1.9
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512111623.35784.max@bbs.cc.uniud.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have frequent freezes with the following setup:
- IDE (PIIX)
- MD (RAID 1)
- SMP (2 CPUs)
- kernel 2.6.14.x

If I unmount the RAID partitions everything is fine (tested on the same 
machine and on a pure SCSI twin). Heavy activity on the IDE disks doesn't 
trigger the problem.
2.6.13.x and 2.6.15-rc5 work flawlessly.
I have many other servers with MD on SCSI and SMP or MS on IDE not SMP. This 
is the only one that has this problem.
Having a working 2.6.15, I shouldn't whine, but I didn't see any bug fixes 
specific to this bug.
Did anyone experience the same problem?

-- 
Bye,
   Massimiliano Hofer
