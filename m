Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262369AbUKVTKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262369AbUKVTKj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 14:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbUKVTJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 14:09:08 -0500
Received: from iris.icglink.com ([216.183.105.244]:8593 "HELO iris.icglink.com")
	by vger.kernel.org with SMTP id S262266AbUKVTGb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 14:06:31 -0500
Date: Mon, 22 Nov 2004 13:06:22 -0600
From: Phil Dier <phil@dier.us>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: oops with dual xeon 2.8ghz  4gb ram +smp, software raid, lvm, and
 xfs
Message-Id: <20041122130622.27edf3e6.phil@dier.us>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm setting up a storage array with Linux, software RAID, LVM, and XFS,
but I keep getting oopses during heavy I/O. I've been able to reproduce
this with 2.6.6, 2.6.8.1, 2.6.9, and 2.6.10-rc2-bk4. I have dual xeon
2.8s with 4gb of ram. I'm using adaptec and a fusion mpt scsi devices
(more details in the following link). Connected are 2 ultra160 scsi
jbods w/ 2 disks apiece. I'm using raid 10 (or should it be 01?) mirrored 
stripes.

Due to its size, I've posted my debug info at this location (I've included
output from all of the above kernels):

<http://www.icglink.com/cluster-debug-info.html> (~235kb)

Please let me know if I've left anything out that would help in locating
the source of the problem.  I'm very willing to try out any patches/config
changes.

please cc me on any replies, as I am not subscribed to the list...

Thanks,

--

Phil Dier (ICGLink.com -- 615 370-1530 x733)

/* vim:set noai nocindent ts=8 sw=8: */
