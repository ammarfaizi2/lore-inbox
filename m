Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315942AbSHFWUF>; Tue, 6 Aug 2002 18:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315946AbSHFWUF>; Tue, 6 Aug 2002 18:20:05 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:6134 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S315942AbSHFWUE>; Tue, 6 Aug 2002 18:20:04 -0400
Date: Tue, 6 Aug 2002 15:21:53 -0700
From: Chris Wright <chris@wirex.com>
To: linux-security-module@wirex.com
Cc: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] 2.5.30-lsm1
Message-ID: <20020806152153.A29152@figure1.int.wirex.com>
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

2.5.30-lsm1 patch released.  This is a rebase to 2.5.30 as well as the
continuation of merging LSM with mainline.

Full lsm-2.5 patch (LSM + all modules) is available at:
	http://lsm.immunix.org/patches/2.5/2.5.30/patch-2.5.30-lsm1.gz

The whole ChangeLog for this release is at:
	http://lsm.immunix.org/patches/2.5/2.5.30/ChangeLog-2.5.30-lsm1

The LSM 2.5 BK tree can be pulled from:
        bk://lsm.bkbits.net/lsm-2.5

2.5.30-lsm1
 - merge with 2.5.27					(Greg KH)
 - merge with 2.5.28-30					(me)
 - bk file merging to handle changes from mainline	(Greg KH)
 - removed BUS_ISA declaration				(Greg KH)
 - add settime hook					(Robb Romans)
 - SELinux: Bug fixes for the PSID mapping code.	(Stephen Smalley)
 - update initlialized to C99 sytle for cap and dummy	(Adam)
   modules.
 - Fix memory leaks in IPC LSM hooking.			(Stephen Smalley)
 - Fix file_lock hooks.					(Matthew Wilcox)
 - update modules according to file_lock hook change	(me)
 - DTE: logic cleanups					(Serge Hallyn)
 - SELinux: cleanup sysctl table			(Chris Vance)
 - __FUNCTION__ cleanup					(Anton Blanchard)
 - remove __exit attribute from selinux_nf_ip_exit	(me)

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
