Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262748AbVDYTi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262748AbVDYTi4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 15:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261471AbVDYTgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 15:36:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21660 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262749AbVDYTeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 15:34:16 -0400
Date: Mon, 25 Apr 2005 11:21:16 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.31-pre1
Message-ID: <20050425142116.GE25420@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here goes the first pre of v2.4.31. 

It contains a very small number of changes, mostly an x86_64 update.

Side note: I'm planning on moving the v2.4 repository along with the full 
history information to a git repository soon. 


Summary of changes from v2.4.30 to v2.4.31-pre1
============================================

Adrian Bunk:
  o MAINTAINERS: remove obsolete ACP/MWAVE MODEM entry

Andi Kleen:
  o x86_64: Handle MM going away in context switch
  o x86_64: Backport 2.6 MTRR algorithms
  o x86_64: noexec=off never worked correctly for the kernel direct mappings
  o x86_64: Fix idle=poll
  o x86_64: Fix reference counting bug in change_page_attr on i386/x86-64
  o x86_64: Resend lost APIC IRQs on Uniprocessor too
  o x86_64: Avoid a obnoxious warning during build
  o x86_64: Flush correctly when more than one page is getting flushed
  o x86_64: Reload init_mm on leaving lazy mm

Andrew Morton:
  o rwsem: Make rwsems use interrupt disabling spinlocks

Herbert Xu:
  o [NETLINK]: Fix sk_rmem_alloc assertion failure in af_netlink.c

Hugh Dickins:
  o madvise_willneed -EIO beyond EOF

Marcelo Tosatti:
  o Change VERSION to 2.4.31-pre1

Pete Zaitcev:
  o visor: Add Zire 31 device ID

