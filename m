Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267455AbSKQEGc>; Sat, 16 Nov 2002 23:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267454AbSKQEGb>; Sat, 16 Nov 2002 23:06:31 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45834 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267455AbSKQEGZ>;
	Sat, 16 Nov 2002 23:06:25 -0500
Date: Sun, 17 Nov 2002 04:13:23 +0000
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org,
       Janitors <kernel-janitor-discuss@lists.sourceforge.net>
Subject: [PATCH] remove sched.h from elf.h
Message-ID: <20021117041323.E20070@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


elf.h simply doesn't need sched.h

diff -urpNX dontdiff linux-2.5.47/include/linux/elf.h linux-2.5.47-pci/include/linux/elf.h
--- linux-2.5.47/include/linux/elf.h	2002-11-14 10:52:17.000000000 -0500
+++ linux-2.5.47-pci/include/linux/elf.h	2002-11-16 22:23:32.000000000 -0500
@@ -1,7 +1,6 @@
 #ifndef _LINUX_ELF_H
 #define _LINUX_ELF_H
 
-#include <linux/sched.h>
 #include <linux/types.h>
 #include <asm/elf.h>
 

-- 
Revolutions do not require corporate support.
