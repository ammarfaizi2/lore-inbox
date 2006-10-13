Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751588AbWJMDaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588AbWJMDaY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 23:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751589AbWJMDaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 23:30:24 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:33428 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751587AbWJMDaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 23:30:23 -0400
Subject: [GIT PATCH] voyager fixes for 2.6.19-rc1
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 12 Oct 2006 22:30:17 -0500
Message-Id: <1160710217.3432.53.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes all the recent breakage in voyager by quite a list of people.

The patch is available here

master.kernel.org:/pub/scm/linux/kernel/git/jejb/voyager-2.6.git

The short log is

James Bottomley:
      [VOYAGER] fix genirq mess
      [VOYAGER] fix up attribute packed specifiers in voyager.h
      [VOYAGER] fix up ptregs removal mess

And the diffstat:

 arch/i386/mach-voyager/voyager_basic.c |    6 -
 arch/i386/mach-voyager/voyager_smp.c   |   52 +++++-----
 include/asm-i386/vic.h                 |    2 
 include/asm-i386/voyager.h             |  160 ++++++++++++++++-----------------
 4 files changed, 113 insertions(+), 107 deletions(-)

James


