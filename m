Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932664AbWBUSsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932664AbWBUSsn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 13:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932668AbWBUSsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 13:48:43 -0500
Received: from kanga.kvack.org ([66.96.29.28]:53433 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S932664AbWBUSsm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 13:48:42 -0500
Date: Tue, 21 Feb 2006 15:48:44 -0600
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Cc: Willy Tarreau <willy@w.ods.org>
Subject: Linux 2.4.33-pre2
Message-ID: <20060221214844.GA22561@dmt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here goes the second -pre of v2.4.33, containing a small number of
changes.

Most notably three security corrections, and an overflow fix for
machines with large amounts of memory and inodes (which would cause the
system's logic to reclaim inodes with highmem pages attached to fail).

Please refer to the changelog for full details...

Summary of changes from v2.4.33-pre1 to v2.4.33-pre2
============================================

Adrian Bunk:
      document that gcc 4 is not supported

dann frazier:
      proc_pid_cmdline() race fix (CAN-2004-1058)

David S. Miller:
      [SPARC]: Fix compile failures in math-emu.

Guennadi Liakhovetski:
      usb-uhci.c: wrong sign comparison in status check

Horms:
      [PATCH, 2.4] wan sdla: fix probable security hole
      orinoco: CVE-2005-3180: Information leakage due to incorrect padding

Jacek Lipkowski:
      make 2.4.32 work on i486 again

Jesse Brandeburg:
      e1000: fix BUG reported due to calling msec_delay in irq context

Marcelo Tosatti:
      Alpha: fix recursive inlining failure in pci_iommu.c
      Merge http://w.ods.org/kernel/2.4/linux-2.4-upstream
      Change VERSION to 2.4.33-pre2

ODonnell, Michael:
      PATCH: hash-table corruption in bond_alb.c

Pete Zaitcev:
      usbserial: using int for CPU flags is incorrect on x86_64

Rik van Riel:
      fix overflow in inode.c

Steven J. Hathaway:
      SAMSUNG CD-ROM SC-140 fails on DMA

Vincent Fortier:
      Documentation error 2.4.x aic7xxx

Willy Tarreau:
      Merge branch 'master' of /data/projets/git/linux/linux-2.4
      Merge branch 'master' of /data/projets/git/linux/linux-2.4

