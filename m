Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261668AbUD1WzD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbUD1WzD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 18:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbUD1WyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 18:54:17 -0400
Received: from [216.150.199.16] ([216.150.199.16]:13201 "EHLO mail.aspsys.com")
	by vger.kernel.org with ESMTP id S261668AbUD1Wxc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 18:53:32 -0400
Date: Wed, 28 Apr 2004 16:53:31 -0600
From: Bryan Stillwell <bryans@aspsys.com>
To: linux-kernel@vger.kernel.org
Subject: Dual Opteron 248s w/ 8GB RAM on Tyan K8W (S2885)
Message-ID: <20040428225331.GA19698@aspsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am having a problem with getting 8GB of RAM to work with the 2.6.5
kernel that Red Hat uses in their new Fedora Core 2 test3 release.  Yes,
not vanilla, but hopefully close enough (otherwise I can try it with a
custom kernel).  The systems (I'm testing on two mostly identical
systems) that are experiencing the problem have these specs:

Motherboard: Tyan K8W (S2885)
Processors: 2 x Opteron 248
Memory: 8 x 1GB
BIOS version: 1.02 (2-3-2004 - latest available)
SCSI card: Adaptec 29320

About 80% of the time I get this error when booting:

...
RAMDISK: Compressed image found at block 0
crc error
VFS: Cannot open root device "<NULL>" or unknown-block(3,2)
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on unknown-block(3,2)


The other 20% of the time it boots up fine, but that's not enough
consistency for these computers final task (beowulf compute nodes).
Also I haven't really stressed the kernel on these boots.

The systems seem to work fine if I pull out half the memory so that they
only has 4GB of RAM.  I've also tested a similar setup using a Rioworks
Arima HDAMA board with 8GB of RAM and it worked.  So I'm led to believe
that this is some kind of driver issue or possibly a bios problem...

Any help/ideas are of course appreciated.

Thanks,
Bryan

-- 
Aspen Systems, Inc.    | http://www.aspsys.com/
Production Engineer    | Phone: (303)431-4606
bryans@aspsys.com      | Fax:   (303)431-7196
