Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317981AbSFST3M>; Wed, 19 Jun 2002 15:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317982AbSFST3M>; Wed, 19 Jun 2002 15:29:12 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:44794 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S317981AbSFST3L>; Wed, 19 Jun 2002 15:29:11 -0400
Date: Wed, 19 Jun 2002 12:29:05 -0700
From: Chris Wright <chris@wirex.com>
To: linux-security-module@wirex.com
Cc: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] 2.5.23-lsm1
Message-ID: <20020619122905.A11517@figure1.int.wirex.com>
Mail-Followup-To: linux-security-module@wirex.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux Security Modules project provides a lightweight, general
purpose framework for access control.  The LSM interface enables
security policies to be developed as loadable kernel modules.
See http://lsm.immunix.org for more information.

2.5.23-lsm1 patch released.  This includes a few base kernel compile
fixes and exports needed for modules.

Full lsm-2.5 patch (LSM + all modules) is available at:
	http://lsm.immunix.org/patches/2.5/2.5.23/patch-2.5.23-lsm1.gz

The whole ChangeLog for this release is at:
	http://lsm.immunix.org/patches/2.5/2.5.23/ChangeLog-2.5.23-lsm1

The LSM 2.5 BK tree can be pulled from:
        bk://lsm.bkbits.net/lsm-2.5

2.5.23-lsm1
 - merge 2.5.21						(Greg KH)
 - vmalloc exports					(AntonA)
 - LIDS #include cleanup				(Greg KH)
 - fix build, add security/built-in.o to Makefile	(Greg KH)
 - merge 2.5.22						(me)
 - sb->s_dev changed to dev_t so update modules
   - DTE: now use MAJOR/MINOR macros			(me)
   - SELinux: now use to_dev_t				(me)
 - SELinux Makefile tweak to build include/asm		(me)
 - merge 2.5.23						(me)
 - SELinux update sysctl SID tables			(Stephen Smalley)
 - various base 2.5.23 compile/export cleanups
   - UP compile fix					(Linus)
   - export default_wake_function			(Ben LaHaise)
   - export ioremap_nocache				(Andi Kleen)
   - drivers/hotplug/cpqphp.h include tqueue.h		(me)
   - fs/smbfs/sock.c include tqueue.h			(Adrian Bunk)

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
