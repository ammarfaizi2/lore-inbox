Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbUBZWct (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 17:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbUBZWcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 17:32:48 -0500
Received: from sweetums.bluetronic.net ([24.199.150.42]:39411 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S261213AbUBZWbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 17:31:15 -0500
Date: Thu, 26 Feb 2004 17:29:03 -0500 (EST)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: kernel/signal.c rev 1.101
Message-ID: <Pine.GSO.4.33.0402261719590.28488-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote the changeset:
  ======== kernel/signal.c 1.101 ========
  D 1.101 04/02/26 03:26:02-08:00 akpm@osdl.org[torvalds] 116 115 0/3/2549
  P kernel/signal.c
  C Kill bogus __KERNEL_SYSCALLS usage
  ------------------------------------------------

That's not "bogus usage" on sparc and sparc64 who's asm/signal.h requires
__NR_restart_syscall.  Removing that breaks things in a way that's very
non-trivial to fix without touching many more files.

--Ricky


