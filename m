Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317872AbSFNCYp>; Thu, 13 Jun 2002 22:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317873AbSFNCYo>; Thu, 13 Jun 2002 22:24:44 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:8947 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S317872AbSFNCYn>; Thu, 13 Jun 2002 22:24:43 -0400
Date: Thu, 13 Jun 2002 19:25:14 -0700
From: Chris Wright <chris@wirex.com>
To: linux-security-module@wirex.com
Cc: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] 2.4.19-pre10-lsm1
Message-ID: <20020613192514.W7369@figure1.int.wirex.com>
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

2.4.19-pre10 lsm patch released.

Full lsm-2.4 patch (LSM + all modules) is available at:
	http://lsm.immunix.org/patches/2.4/2.4.19/patch-2.4.19-pre10-lsm1.gz

The whole ChangeLog for this release is at:
	http://lsm.immunix.org/patches/2.4/2.4.19/ChangeLog-2.4.19-pre10-lsm1

The LSM 2.4 development BK tree can be pulled from:
	bk://lsm.bkbits.net/lsm-2.4-dev

2.4.19-pre10-lsm1
 - merge through 2.4.19-pre10				(me)
 - LIDS #include cleanup				(me)
 - add official ia64 number for sys_security		(Richard Offer)
 							(Greg KH)

2.4.18-lsm3
 - SELinux updates					(Stephen Smalley)
   - build updates
   - permit blocking allocate during policy load
   - update enforcing mode selection
   - locking fixes
   - backport relevant 2.5 exec_permission_lite changes
   - added comm to audit msg
   - make extened socket call processing optional
   - enhanced MLS support

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
