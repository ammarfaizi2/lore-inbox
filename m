Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030471AbVLWJbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030471AbVLWJbr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 04:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030472AbVLWJbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 04:31:47 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:61083 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030471AbVLWJbr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 04:31:47 -0500
Date: Fri, 23 Dec 2005 09:31:46 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: [PATCHSET] 2.6.15-rc6-bird2
Message-ID: <20051223093146.GT27946@ftp.linux.org.uk>
References: <20051222101523.GP27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051222101523.GP27946@ftp.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Updated version:
ftp://ftp.linux.org.uk/pub/people/viro/patch-2.6.15-bird2.bz2

URL of splitup: same place, bird-mbox.
 
Changes since yesterday snapshot:

Al Viro:
      dead code removed in hp100
      m32r: C99 initializers in setup.c
      m32r: NULL noise removal
      m32r: signal __user annotations
      m68k: kill mach_floppy_setup, convert to proper __setup() in drivers
      m68k: fix use of void foo(void) asm("bar") in traps.c
      drive_info removal outside of arch/i386

Alexey Dobriyan:
      nbd: add endian annotations
      aes: fix endian warnings
      serpent: fix endian warnings
      chelsio: add endian annotations

[pulled from m68k CVS]
Kars de Jong:
      m68k: Moved initialisation of conswitchp from subarches to global arch
setup
