Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbVL2Qkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbVL2Qkm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 11:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbVL2Qkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 11:40:42 -0500
Received: from hera.kernel.org ([140.211.167.34]:47318 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750759AbVL2Qkl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 11:40:41 -0500
Date: Thu, 29 Dec 2005 14:31:05 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Cc: Willy Tarreau <willy@w.ods.org>
Subject: Linux 2.4.33-pre1
Message-ID: <20051229163105.GA6226@dmt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi! 

Here goes the first -pre of v2.4.33 - it contains a bunch of security
related fixes (mostly DoS fixes), the last large SATA update, sis900 
update, amongst others.


Summary of changes from v2.4.32 to v2.4.33-pre1
============================================

Adrian Bunk:
      airo.c/airo_cs.c: correct prototypes
      drivers/scsi/dpt_i2o.c: fix a NULL pointer dereference

Akira Tsukamoto:
      fix for clock running too fast
      ide: add recent ATI IXP300/400 PATA support

Chris Ross:
      Don't panic on IDE DMA errors

dann frazier:
      Backport of CVE-2005-2709 fix

Dave Anderson:
      x86-64: user code panics kernel in exec.c (CVE-2005-2708)

David S. Miller:
      [SPARC64]: Fix trap state reading for instruction_access_exception.
      [SPARC64]: Do not call winfix_dax blindly
      [SPARC64]: Revamp Spitfire error trap handling.
      [SPARC64]: More fully work around Spitfire Errata 51.
      [IPV6] mcast: IPV6 side of IGMP DoS fix.

David Stevens:
      [IGMP]: workaround for IGMP v1/v2 bug

Horms:
      local denial-of-service with file lease

Jeff Garzik:
      [libata] resync with kernel 2.6.13
      [libata sata_sx4] trim trailing whitespace
      [libata] resync with 2.6.14
      [libata] resync with 2.6.15-rc3
      [libata] fix build
      [libata] fix potential oops in pdev_printk() compat helper

Karl Magnus Kolstoe:
      add Pioneer DRM-624X to drivers/scsi/scsi_scan.c

Konstantin Khorenko:
      sis900: come alive after temporary memory shortage

Krzysztof Strasburger:
      NFS server as a module with -mregparm=3

Linus Torvalds:
      Fix ptrace self-attach rule (2.6 backport)

Maciej W. Rozycki:
      fs/smbfs/proc.c: fix data corruption in smb_proc_setattr_unix()

Marcelo Tosatti:
      Revert broken sis900 update
      Merge http://w.ods.org/kernel/2.4/linux-2.4-upstream
      Change VERSION to 2.4.33-pre1
      Merge master.kernel.org:/.../davem/net-2.4

Marcus Meissner:
      Fix sendmsg overflow (CVE-2005-2490)

NeilBrown:
      dcache: avoid race when updating nr_unused count of unused dentries

Nick Warne:
      Reintroduction i386 CONFIG_DUMMY_KEYB option

Pete Zaitcev:
      usb: ehci in 2.4 with async_unlink

Vasily Averin:
      sis900: come alive after temporary memory shortage (fixed version)
      aic7xxx: reset handler selects a wrong command

Vijay Sampath:
      MTD: kernel stuck in tight loop occasionally on flash access

Willy Tarreau:
      IPv6: small fix for ip6_mc_msfilter
      Fix SATA update KM_IRQ issue with highmem

Yan Zheng:
      IPv6: fix refcnt of struct ip6_flowlabel

