Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267642AbSLSKpa>; Thu, 19 Dec 2002 05:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267643AbSLSKp3>; Thu, 19 Dec 2002 05:45:29 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:53235 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S267642AbSLSKo5>; Thu, 19 Dec 2002 05:44:57 -0500
Date: Thu, 19 Dec 2002 02:51:23 -0800
From: Chris Wright <chris@wirex.com>
To: linux-security-module@wirex.com
Cc: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] 2.5.52-lsm1
Message-ID: <20021219025123.A23371@figure1.int.wirex.com>
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

2.5.52-lsm1 patch released.  This is a rebase up to 2.5.52 as well as
numerous module updates and bugfixes.  The interface has changed, and
the hooks are controlled with CONFIG_SECURITY now.  Currently LIDS and
DTE will not compile.

Full lsm-2.5 patch (LSM + all modules) is available at:
	http://lsm.immunix.org/patches/2.5/2.5.52/patch-2.5.52-lsm1.gz

The whole ChangeLog for this release is at:
	http://lsm.immunix.org/patches/2.5/2.5.52/ChangeLog-2.5.52-lsm1

The LSM 2.5 BK tree can be pulled from:
        bk://lsm.bkbits.net/lsm-2.5

2.5.52-lsm1
 - merge with 2.5.36-52					(GregKH and me)
 - Owlsm module updates					(GregKH)
 - Makefile and Kconfig cleanups			(GregKH)
 - SELinux: Assign an initial SID to SCMP packets.	(Wayne Salamon)
 - dummy module cleanups				(GregKH)
 - convert hooks to new format				(GregKH)
 							(Stephen Smalley)
 - add CONFIG_SECURITY					(GregKH)
 - SELinux: Handles inodes allocated by AFS		(Stephen Smalley)
 - SELinux: kill uses of i_dev				(Stephen Smalley)
 - LIDS 2.0.2pre2 update				(Huagang Xie)
 - Add hook to init_private_file/release_private_file	(Stephen Smalley)
 - remove sys_security					(Christoph Hellwig)
 - LIDS fix __FUNCTION__ pasting			(me)
 - Kconfig updates					(me)
 - LIDS workqueue conversion and bug fix		(Huagang Xie)
 - IPC hooks cleanup					(Stephen Smalley)
 - Selopt __exit fixups					(Stephen Smalley)
 - remove file_llseek					(Christoph Hellwig)
 - SELinux: remove inode_preconditions			(Stephen Smalley)
 - Added gfp_mask param to skb_alloc_security() hook	(James Morris)
 - SELinux: pivot_root, connect revalidation bug fixes
   kbd ioctl fix, signull perm, remove old perm.	(Stephen Smalley)
 - LIDS update to for_each_process			(me)

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
