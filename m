Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275178AbRIZNSO>; Wed, 26 Sep 2001 09:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275179AbRIZNSE>; Wed, 26 Sep 2001 09:18:04 -0400
Received: from heffalump.fnal.gov ([131.225.9.20]:8311 "EHLO fnal.gov")
	by vger.kernel.org with ESMTP id <S275178AbRIZNRz>;
	Wed, 26 Sep 2001 09:17:55 -0400
Date: Wed, 26 Sep 2001 08:18:22 -0500 (CDT)
From: vkuznet <vkuznet@fnal.gov>
Subject: problem with 2.4.8 and "Checking root filesystem"
To: linux-kernel@vger.kernel.org
Message-id: <Pine.LNX.4.33.0109260811240.2579-100000@vk-clued0.fnal.gov>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm trying to install kernel 2.4.8 with Alan's patches (AC) plus XFS.
I took vanilla kernel, applied all patches and build successfully
kernel. When I reboot system, kernel was loaded and on my RedHat 7.1
booting sequence stopped at
Checking root filesystem...
and wait forever. It doesn't try to invoke fsck for root file system,
just wait for something. Reading Documentation/Changes for new kernel
I check out that have all appropriate packages (all needed vesions
of e2fsprogs, etc.) Any idea what happens and how to fix?

System Dual PIII, SCSI disks (Adaptec AIC7xxx), root on ext2, the rest on xfs.

I'll appreciate if you personally CC'ed the answers/comments to my Email
since I'm still not in kernel mailing list.

Regards,
Valentin.

