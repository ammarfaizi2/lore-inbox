Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275357AbRIZR1c>; Wed, 26 Sep 2001 13:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275356AbRIZR1W>; Wed, 26 Sep 2001 13:27:22 -0400
Received: from post.aecom.yu.edu ([129.98.1.4]:22982 "EHLO post.aecom.yu.edu")
	by vger.kernel.org with ESMTP id <S275357AbRIZR1M>;
	Wed, 26 Sep 2001 13:27:12 -0400
Mime-Version: 1.0
Message-Id: <a0510031eb7d7bfead585@[129.98.91.150]>
In-Reply-To: <Pine.LNX.4.33.0109260811240.2579-100000@vk-clued0.fnal.gov>
In-Reply-To: <Pine.LNX.4.33.0109260811240.2579-100000@vk-clued0.fnal.gov>
Date: Wed, 26 Sep 2001 13:27:30 -0400
To: vkuznet <vkuznet@fnal.gov>
From: Maurice Volaski <mvolaski@aecom.yu.edu>
Subject: Re: problem with 2.4.8 and "Checking root filesystem"
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi,
>I'm trying to install kernel 2.4.8 with Alan's patches (AC) plus XFS.
>I took vanilla kernel, applied all patches and build successfully
>kernel. When I reboot system, kernel was loaded and on my RedHat 7.1
>booting sequence stopped at
>Checking root filesystem...
>and wait forever. It doesn't try to invoke fsck for root file system,
>just wait for something. Reading Documentation/Changes for new kernel
>I check out that have all appropriate packages (all needed vesions
>of e2fsprogs, etc.) Any idea what happens and how to fix?
>
>System Dual PIII, SCSI disks (Adaptec AIC7xxx), root on ext2, the rest on xfs.
>
>I'll appreciate if you personally CC'ed the answers/comments to my Email
>since I'm still not in kernel mailing list.
>

I am seeing the same problem on a single processor system but I am 
running 2.4.10 with ext3 and the kdb patch. Root happens to be ext2.

-- 

Maurice Volaski, mvolaski@aecom.yu.edu
Computing Support, Rose F. Kennedy Center
Albert Einstein College of Medicine of Yeshiva University
