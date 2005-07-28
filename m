Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261652AbVG1Q3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbVG1Q3K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 12:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbVG1Q1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 12:27:43 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:57304 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261573AbVG1QZg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 12:25:36 -0400
Date: Fri, 29 Jul 2005 02:08:02 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/6] Consolidate asm/fcntl.h
Message-Id: <20050729020802.22b7656c.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I finally got inspired enough to consolidate all the asm-*/fcntl.h files. 
This set of patches is the result.

Comments?

This has only been built in PPC64 - others are welcome to try as well :-)

---
 asm-alpha/fcntl.h   |   35 ------------
 asm-arm/fcntl.h     |   78 ---------------------------
 asm-arm26/fcntl.h   |   76 --------------------------
 asm-cris/fcntl.h    |   91 -------------------------------
 asm-frv/fcntl.h     |   89 -------------------------------
 asm-generic/fcntl.h |  149 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 asm-h8300/fcntl.h   |   78 ---------------------------
 asm-i386/fcntl.h    |   89 -------------------------------
 asm-ia64/fcntl.h    |   78 ---------------------------
 asm-m32r/fcntl.h    |   93 --------------------------------
 asm-m68k/fcntl.h    |   78 ---------------------------
 asm-mips/fcntl.h    |   75 ++------------------------
 asm-parisc/fcntl.h  |   56 -------------------
 asm-ppc/fcntl.h     |   88 +-----------------------------
 asm-ppc64/fcntl.h   |   90 -------------------------------
 asm-s390/fcntl.h    |   98 ----------------------------------
 asm-sh/fcntl.h      |   89 -------------------------------
 asm-sh64/fcntl.h    |    6 --
 asm-sparc/fcntl.h   |   61 +--------------------
 asm-sparc64/fcntl.h |   46 ----------------
 asm-v850/fcntl.h    |   78 ---------------------------
 asm-x86_64/fcntl.h  |   77 --------------------------
 asm-xtensa/fcntl.h  |   48 +---------------
 23 files changed, 188 insertions(+), 1558 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
