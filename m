Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315946AbSHFWUc>; Tue, 6 Aug 2002 18:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315988AbSHFWUc>; Tue, 6 Aug 2002 18:20:32 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:13302 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S315946AbSHFWUa>; Tue, 6 Aug 2002 18:20:30 -0400
Date: Tue, 6 Aug 2002 15:22:19 -0700
From: Chris Wright <chris@wirex.com>
To: linux-security-module@wirex.com
Cc: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] 2.4.19-lsm1
Message-ID: <20020806152219.A29159@figure1.int.wirex.com>
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

2.4.19 lsm patch released.  This is includes bugfixes and merging up to
the current stable 2.4 Linux tree.

Full lsm-2.4 patch (LSM + all modules) is available at:
	http://lsm.immunix.org/patches/2.4/2.4.19/patch-2.4.19-lsm1.gz

The whole ChangeLog for this release is at:
	http://lsm.immunix.org/patches/2.4/2.4.19/ChangeLog-2.4.19-lsm1

The LSM 2.4 stable BK tree can be pulled from:
        bk://lsm.bkbits.net/lsm-2.4

2.4.19-lsm1
 - merge through 2.4.19-rc5				(me)
 - merge with 2.4.19 final				(James Morris)
 - SELinux: Bug fixes for the PSID mapping code.	(Stephen Smalley)
 - Fix memory leaks in IPC LSM hooking.			(Stephen Smalley)
 - Fix file_lock hooks.					(Matthew Wilcox)
 - update modules according to file_lock hook change	(me)
 - add settime() hook					(Robb Romans)
 - remove __exit attribute from selinux_nf_ip_exit	(me)

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
