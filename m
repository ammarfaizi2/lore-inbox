Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbWHSOOB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWHSOOB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 10:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751758AbWHSOOB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 10:14:01 -0400
Received: from hera.kernel.org ([140.211.167.34]:62895 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751524AbWHSON6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 10:13:58 -0400
Date: Sat, 19 Aug 2006 14:13:55 +0000
From: Willy Tarreau <wtarreau@hera.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: mtosatti@redhat.com
Subject: Linux 2.4.33.1
Message-ID: <20060819141355.GA6302@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

As there were a few security fixes pending and 2.4.34-pre1 has not
received enough validation, I've released 2.4.33.1 with the most
important fixes. All those fixes are already in 2.4.34-pre1.

Particularly important ones are :
 - CVE-2006-1528 : local DoS via direct I/O from the sg driver to mmapped I/O space
   fix from Dann Frazier
 - CVE-2006-4093 : possible local DoS on some PPC970.
   fix from Olof Johansson

Hotfix patches for older versions should follow within a short time.

Regards,
Willy

Summary of changes from v2.4.33 to v2.4.33.1
============================================

dann frazier:
      drivers/scsi/sg.c : fix CVE-2006-1528

Jeff Layton:
      2.4 NFS client - update d_cache when server reports ENOENT on an NFS remove

Willy Tarreau:
      [BLKMTD] : missing offset sometimes causes panics
      [PKTGEN] : fix an oops when used with bonding driver (Tien ChenLi)
      export memchr() which is used by smbfs and lp driver.
      powerpc: Clear HID0 attention enable on PPC970 at boot time
      Change VERSION to 2.4.33.1


