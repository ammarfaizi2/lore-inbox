Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751293AbWEAHHj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbWEAHHj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 03:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbWEAHHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 03:07:39 -0400
Received: from kanga.kvack.org ([66.96.29.28]:29921 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751293AbWEAHHi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 03:07:38 -0400
Date: Mon, 1 May 2006 04:07:40 -0300
From: Marcelo Tosatti <marcelo@kvack.org>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.33-pre3
Message-ID: <20060501070740.GA28087@dmt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After a long time, here comes the third -pre of v2.4.33.

Mostly security related fixes, as usual.

Note: The mprotect issue, ID CVE-2006-1524, has changed to
CVE-2006-2071.

Summary of changes from v2.4.33-pre2 to v2.4.33-pre3
============================================

Andi Kleen:
      x86_64: Check for bad elf entry address.
      Always check that RIPs are canonical during signal handling
      x86-64: Always check that RIPs are canonical during signal handling (update)
      i386/x86-64: Fix x87 information leak between processes

Craig Brind:
      via-rhine: zero pad short packets on Rhine I ethernet cards

David S. Miller:
      ip_queue: Fix wrong skb->len == nlmsg_len assumption

Hugh Dickins:
      fix shm mprotect (CVE-2006-1524)

Jeff Layton:
      2.4 nfs cache consistency problem with mmap'ed files

Jesse Brandeburg:
      build fix: auto_fs4 changes broke ppc64 build

Marcelo Tosatti:
      Merge http://w.ods.org/kernel/2.4/linux-2.4-upstream
      Change VERSION to v2.4.33-pre3
      Fix printk length modifier of NFS mmap consistency patch

Marek Szuba:
      quota_v2 module taints the kernel (missing licence)

Marin Mitov:
      DRM: drm_stub_open() range checking

Mika Kukkonen:
      VLAN: Add two missing checks to vlan_ioctl_handler()

Pavel Kankovsky:
      Fix small information leak in SO_ORIGINAL_DST and getname()

Stefan-W. Hahn:
      Corrected faulty syntax in drivers/input/Config.in

Stephen Rothwell:
      PPC64: fix sys_rt_sigreturn() return type

Willy TARREAU:
      e1000: Fix mii-tool access to setting speed and duplex

