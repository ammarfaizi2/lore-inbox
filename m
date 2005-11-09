Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751479AbVKIVhJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbVKIVhJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 16:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbVKIVhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 16:37:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:12235 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751479AbVKIVhG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 16:37:06 -0500
Date: Wed, 9 Nov 2005 13:35:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       "Brown, Len" <len.brown@intel.com>, Jeff Garzik <jgarzik@pobox.com>,
       "Luck, Tony" <tony.luck@intel.com>, Ben Collins <bcollins@debian.org>,
       Jody McIntyre <scjody@modernduck.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Roland Dreier <rolandd@cisco.com>, Dave Jones <davej@codemonkey.org.uk>,
       Jens Axboe <axboe@suse.de>, Dave Kleikamp <shaggy@austin.ibm.com>,
       Steven French <sfrench@us.ibm.com>
Subject: merge status
Message-Id: <20051109133558.513facef.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We're at day 12 of the two-week window, time for a quick peek at
outstanding patches in the subsystem trees.

-rw-r--r--    1 akpm     akpm       339882 Nov  9 11:19 git-scsi-misc.patch
-rw-r--r--    1 akpm     akpm       188863 Nov  9 11:29 git-acpi.patch
-rw-r--r--    1 akpm     akpm       151205 Nov  9 11:19 git-libata-all.patch
-rw-r--r--    1 akpm     akpm        78245 Nov  9 11:19 git-ia64.patch
-rw-r--r--    1 akpm     akpm        71651 Nov  9 11:19 git-ieee1394.patch
-rw-r--r--    1 akpm     akpm        71552 Nov  9 11:19 git-audit.patch
-rw-r--r--    1 akpm     akpm        47649 Nov  9 11:19 git-cryptodev.patch
-rw-r--r--    1 akpm     akpm        21829 Nov  9 11:19 git-blktrace.patch
-rw-r--r--    1 akpm     akpm        20989 Nov  9 11:19 git-infiniband.patch
-rw-r--r--    1 akpm     akpm         6687 Nov  9 11:19 git-agpgart.patch
-rw-r--r--    1 akpm     akpm         6569 Nov  9 11:19 git-cifs.patch
-rw-r--r--    1 akpm     akpm         2435 Nov  9 11:19 git-ntfs.patch
-rw-r--r--    1 akpm     akpm         1193 Nov  9 11:19 git-jfs.patch

The below are empty:

-rw-r--r--    1 akpm     akpm          131 Nov  9 11:19 git-block.patch
-rw-r--r--    1 akpm     akpm          124 Oct 23 11:38 git-watchdog.patch
-rw-r--r--    1 akpm     akpm          123 Nov  9 11:19 git-drm-via.patch
-rw-r--r--    1 akpm     akpm          122 Nov  9 11:19 git-scsi-rc-fixes.patch
-rw-r--r--    1 akpm     akpm          122 Nov  9 11:19 git-drm.patch
-rw-r--r--    1 akpm     akpm          118 Nov  9 11:19 git-alsa.patch
-rw-r--r--    1 akpm     akpm          115 Nov  9 11:19 git-sparc64.patch
-rw-r--r--    1 akpm     akpm          113 Nov  9 11:19 git-cpufreq.patch
-rw-r--r--    1 akpm     akpm          112 Nov  9 11:19 git-mtd.patch
-rw-r--r--    1 akpm     akpm          110 Nov  9 11:19 git-kbuild.patch
-rw-r--r--    1 akpm     akpm          110 Nov  9 11:19 git-input.patch
-rw-r--r--    1 akpm     akpm          102 Nov  9 11:19 git-nfs.patch
-rw-r--r--    1 akpm     akpm          102 Nov  9 11:19 git-drvmodel.patch
-rw-r--r--    1 akpm     akpm          101 Nov  9 11:19 git-arm-smp.patch
-rw-r--r--    1 akpm     akpm          100 Nov  9 11:19 git-serial.patch
-rw-r--r--    1 akpm     akpm           97 Nov  9 11:19 git-ucb.patch
-rw-r--r--    1 akpm     akpm           97 Nov  9 11:19 git-mmc.patch
-rw-r--r--    1 akpm     akpm           97 Nov  9 11:19 git-arm.patch
-rw-r--r--    1 akpm     akpm           87 Nov  9 11:19 git-xfs.patch

Most of this will be 2.6.16 material.  If not, promptness is urged.
