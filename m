Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262112AbULaPt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262112AbULaPt6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 10:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbULaPt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 10:49:58 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:36019 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262112AbULaPt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 10:49:56 -0500
Subject: [BK PATCH] voyager (and subarch) updates
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, pazke@donpac.ru
Content-Type: text/plain
Date: Fri, 31 Dec 2004 09:49:41 -0600
Message-Id: <1104508181.5247.7.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've had this in my voyager tree for a while ... it contains two bug
fixes (double #include and a missing iounmap) and also the reboot rework
which affects VISWS as well.

The patch is available here:

bk://linux-voyager.bkbits.net/voyager-2.6

The short changelog is:

Adrian Bunk:
  o i386: reboot.c cleanups
  o i386 voyager_smp.c: remove a duplicate #include

James Bottomley:
  o dma_release_declared_memory needs iounmap

And the diffstat is:
 kernel/pci-dma.c             |    1 +
 kernel/reboot.c              |    2 +-
 mach-visws/reboot.c          |    3 ---
 mach-voyager/voyager_basic.c |    2 --
 mach-voyager/voyager_smp.c   |    3 ---
 5 files changed, 2 insertions(+), 9 deletions(-)

James


