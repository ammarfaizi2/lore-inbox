Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964939AbWILGTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964939AbWILGTR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 02:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbWILGTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 02:19:16 -0400
Received: from smtp.ocgnet.org ([64.20.243.3]:30665 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S1751282AbWILGTJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 02:19:09 -0400
Date: Tue, 12 Sep 2006 15:18:52 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] sh64: Trivial fixes.
Message-ID: <20060912061852.GA9249@localhost.na.rta>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh64-2.6.git

Which contains:

Paul Mundt:
      sh64: Drop deprecated ISA tuning for legacy toolchains.
      sh64: Trivial build fixes.
      sh64: Use generic BUG_ON()/WARN_ON().
      sh64: Add a sane pm_power_off implementation.

 arch/sh64/Makefile             |    1 -
 arch/sh64/kernel/process.c     |    3 +++
 arch/sh64/mach-cayman/setup.c  |    6 ++++--
 arch/sh64/mm/ioremap.c         |    4 +++-
 drivers/serial/sh-sci.c        |    4 ++--
 include/asm-sh64/bug.h         |   16 ++++------------
 include/asm-sh64/byteorder.h   |    4 ++--
 include/asm-sh64/dma-mapping.h |   16 ++++++++++++----
 include/asm-sh64/io.h          |    7 +++++++
 include/asm-sh64/ptrace.h      |    2 +-
 include/asm-sh64/system.h      |    2 +-
 include/asm-sh64/uaccess.h     |   19 +++++++------------
 12 files changed, 46 insertions(+), 38 deletions(-)
