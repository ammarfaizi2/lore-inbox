Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316039AbSFETK7>; Wed, 5 Jun 2002 15:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316079AbSFETK7>; Wed, 5 Jun 2002 15:10:59 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:59374 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S316039AbSFETK5>; Wed, 5 Jun 2002 15:10:57 -0400
Date: Wed, 5 Jun 2002 12:10:09 -0700
From: Chris Wright <chris@wirex.com>
To: linux-security-module@wirex.com
Cc: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] 2.4.18-lsm3
Message-ID: <20020605121009.A24505@figure1.int.wirex.com>
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

Updated 2.4.18 lsm patch released.

Full lsm-2.4 patch (LSM + all modules) is available at:
	http://lsm.immunix.org/patches/2.4/2.4.18/patch-2.4.18-lsm3.gz

The whole ChangeLog for this release is at:
	http://lsm.immunix.org/patches/2.4/2.4.18/ChangeLog-2.4.18-lsm3

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

2.4.18-lsm2
 - remerge with 2.4.18, merge error			(me)
 - update to LIDS 2.0.1pre3				(Huagang Xie)
   - many bug fixes and code cleanups
   - use single source tree for 2.4/2.5
   - stackable with owlsm
 - SELinux updates					(Stephen Smalley)
   - many bug fixes and code cleanups
   - security server locking updates
   - Merge Selopt from James Morris
   - add support for owlsm stacking
   - deadlock fixes
 - added socket post_accept and skb recv_datagram hooks (Chris Vance)
 - fixed lsm netfilter hook placement			(James Morris)
 - add pivotroot and post_pivotroot hooks		(Stephen Smalley)

2.4.18-lsm1
 - 2.4.18-pre and 2.4.18 merges                         (me)
 - make sure sys_setgroups16 is mediated                (Antony
   Edwards/me)
 - fcntl_*lk* cleanups                                  (me)
 - file_ops->lock support for fcntl style locks         (Antony
   Edwards/me)
 - multiple DTE cleanups                                (Serge Hallyn)
 - add binprm check_security hook                       (Huagang Xie)
 - add LIDS module to tree                              (Huagang Xie)
 - replace binfmt_elf.c fix lost in 2.4.18              (me)

thanks,
-chris

-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
