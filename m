Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263041AbUDLTcP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 15:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263058AbUDLTcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 15:32:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62642 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263041AbUDLTcL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 15:32:11 -0400
Date: Mon, 12 Apr 2004 16:33:13 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.26-rc3
Message-ID: <20040412193313.GA5504@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

Here goes the third release candidate.

It includes few important USB fixes, JFS fixes, amongst others.


Detailed changelog follows

Summary of changes from v2.4.26-rc2 to v2.4.26-rc3
============================================

<joel.becker:oracle.com>:
  o Add Xserve RAID LUN to SCSI whitelist

Andi Kleen:
  o Handle node zero with no memory on x86-64

Andrew Morton:
  o sk_mca multicast fix

Chris Wright:
  o fix load_elf_binary error path on unshare_files error
  o fix another load_elf_binary error path

Dave Kleikamp:
  o JFS: Add lots of missing statics and remove dead code
  o JFS: Prevent hang in __lock_metapage
  o JFS: Fix race in jfs_sync

Ivan Kokshaysky:
  o Herbert Xu: Fix Alpha unaligned stxncpy again

Marcelo Tosatti:
  o Martin Schulze: Improve r128 DRM driver checks
  o Changed EXTRAVERSION to -rc3

Pete Zaitcev:
  o USB update
  o Fix SMP issues with USB-storage/ohci-hcd

Stephen Rothwell:
  o make 2.4 boot when built with gcc 3.4

