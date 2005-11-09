Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030436AbVKIWNY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030436AbVKIWNY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 17:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030438AbVKIWNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 17:13:24 -0500
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:37523 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1030436AbVKIWNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 17:13:22 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Wed, 9 Nov 2005 22:13:11 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>,
       "Brown, Len" <len.brown@intel.com>, Jeff Garzik <jgarzik@pobox.com>,
       "Luck, Tony" <tony.luck@intel.com>, Ben Collins <bcollins@debian.org>,
       Jody McIntyre <scjody@modernduck.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Roland Dreier <rolandd@cisco.com>, Dave Jones <davej@codemonkey.org.uk>,
       Jens Axboe <axboe@suse.de>, Dave Kleikamp <shaggy@austin.ibm.com>,
       Steven French <sfrench@us.ibm.com>
Subject: Re: merge status
In-Reply-To: <20051109133558.513facef.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0511092203320.19282@hermes-1.csi.cam.ac.uk>
References: <20051109133558.513facef.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Nov 2005, Andrew Morton wrote:

> 
> We're at day 12 of the two-week window, time for a quick peek at
> outstanding patches in the subsystem trees.
> 
> -rw-r--r--    1 akpm     akpm       339882 Nov  9 11:19 git-scsi-misc.patch
> -rw-r--r--    1 akpm     akpm       188863 Nov  9 11:29 git-acpi.patch
> -rw-r--r--    1 akpm     akpm       151205 Nov  9 11:19 git-libata-all.patch
> -rw-r--r--    1 akpm     akpm        78245 Nov  9 11:19 git-ia64.patch
> -rw-r--r--    1 akpm     akpm        71651 Nov  9 11:19 git-ieee1394.patch
> -rw-r--r--    1 akpm     akpm        71552 Nov  9 11:19 git-audit.patch
> -rw-r--r--    1 akpm     akpm        47649 Nov  9 11:19 git-cryptodev.patch
> -rw-r--r--    1 akpm     akpm        21829 Nov  9 11:19 git-blktrace.patch
> -rw-r--r--    1 akpm     akpm        20989 Nov  9 11:19 git-infiniband.patch
> -rw-r--r--    1 akpm     akpm         6687 Nov  9 11:19 git-agpgart.patch
> -rw-r--r--    1 akpm     akpm         6569 Nov  9 11:19 git-cifs.patch

> -rw-r--r--    1 akpm     akpm         2435 Nov  9 11:19 git-ntfs.patch

Odd.  "git format-patch -n `cat 
/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/HEAD`" returns nothing so 
I can only assume that it is empty, too.  No idea why the size is 2.4k...  
Certainly I do not remember committing anything since I last pushed to 
Linus...

> -rw-r--r--    1 akpm     akpm         1193 Nov  9 11:19 git-jfs.patch
> 
> The below are empty:
> 
> -rw-r--r--    1 akpm     akpm          131 Nov  9 11:19 git-block.patch
> -rw-r--r--    1 akpm     akpm          124 Oct 23 11:38 git-watchdog.patch
> -rw-r--r--    1 akpm     akpm          123 Nov  9 11:19 git-drm-via.patch
> -rw-r--r--    1 akpm     akpm          122 Nov  9 11:19 git-scsi-rc-fixes.patch
> -rw-r--r--    1 akpm     akpm          122 Nov  9 11:19 git-drm.patch
> -rw-r--r--    1 akpm     akpm          118 Nov  9 11:19 git-alsa.patch
> -rw-r--r--    1 akpm     akpm          115 Nov  9 11:19 git-sparc64.patch
> -rw-r--r--    1 akpm     akpm          113 Nov  9 11:19 git-cpufreq.patch
> -rw-r--r--    1 akpm     akpm          112 Nov  9 11:19 git-mtd.patch
> -rw-r--r--    1 akpm     akpm          110 Nov  9 11:19 git-kbuild.patch
> -rw-r--r--    1 akpm     akpm          110 Nov  9 11:19 git-input.patch
> -rw-r--r--    1 akpm     akpm          102 Nov  9 11:19 git-nfs.patch
> -rw-r--r--    1 akpm     akpm          102 Nov  9 11:19 git-drvmodel.patch
> -rw-r--r--    1 akpm     akpm          101 Nov  9 11:19 git-arm-smp.patch
> -rw-r--r--    1 akpm     akpm          100 Nov  9 11:19 git-serial.patch
> -rw-r--r--    1 akpm     akpm           97 Nov  9 11:19 git-ucb.patch
> -rw-r--r--    1 akpm     akpm           97 Nov  9 11:19 git-mmc.patch
> -rw-r--r--    1 akpm     akpm           97 Nov  9 11:19 git-arm.patch
> -rw-r--r--    1 akpm     akpm           87 Nov  9 11:19 git-xfs.patch
> 
> Most of this will be 2.6.16 material.  If not, promptness is urged.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
