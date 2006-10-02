Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965118AbWJBVIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965118AbWJBVIa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 17:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965120AbWJBVIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 17:08:30 -0400
Received: from hera.kernel.org ([140.211.167.34]:12169 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S965118AbWJBVI3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 17:08:29 -0400
Date: Mon, 2 Oct 2006 21:08:21 +0000
From: Willy Tarreau <wtarreau@hera.kernel.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Linux 2.4.34-pre4
Message-ID: <20061002210821.GA5700@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there !

This is version 2.4.34-pre4. Very minor fixes as well as a backport of the
fix for CVE-2006-4997 by Dann Frazier.

I'm pretty happy with the gcc4 fixes, a few people reported success and
nobody complained yet. One of the OpenWRT developers offered to contribute
MIPS patches from his project, but as I don't have a toolchain anymore, I
will not be able to break them into pieces before merging them. I asked
him to do all the dirty and thankless job, but I don't know if he will
feel brave enough. I might try to perform an Alpha port when I receive
my memory upgrade. If other people want to contribute gcc4 fixes for other
archs, they're welcome, but *please* provide one patch per build error
with the copy of the error in the commit.

I will wait a bit more for fixes and will soon enter -rc as things calm
down. If I find some spare time, I will release 2.4.33.4 with minor fixes,
and even possibly resync the hotfix tree for users of older versions.

Have fun,
Willy

Summary of changes from v2.4.34-pre3 to v2.4.34-pre4
============================================

dann frazier:
      Backport fix for CVE-2006-4997 to 2.4 tree

Geert Uytterhoeven:
      fbdev: correct buffer size limit in fbmem_read_proc()

Jurzitza, Dieter:
      really fix size display for sun partitions larger than 1TByte

Michael Chen:
      i386: fix overflow in vmap on an x86 system which has more than 4GB memory.

mostrows@earthlink.net:
      Advertise PPPoE MTU

PaX Team:
      MIPS: fix long long cast in pte macro
      i386: fix long long cast in pte macro

Steffen Maier:
      block: fix negative bias of ios_in_flight (CONFIG_BLK_STATS) because of unbalanced I/O accounting

Toyo Abe:
      x86_64: Fix missing delay when the TSC counter just overflowed

Willy Tarreau:
      fix Configure.help concerning rp_filter
      Change VERSION to 2.4.34-pre4

