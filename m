Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264587AbSIQT6V>; Tue, 17 Sep 2002 15:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264588AbSIQT6V>; Tue, 17 Sep 2002 15:58:21 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:37873 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S264587AbSIQT6U>; Tue, 17 Sep 2002 15:58:20 -0400
Date: Tue, 17 Sep 2002 12:57:20 -0700
From: Chris Wright <chris@wirex.com>
To: linux-security-module@wirex.com
Cc: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] 2.5.35-lsm1
Message-ID: <20020917125720.K1972@figure1.int.wirex.com>
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

2.5.35-lsm1 patch released.  This is a rebase up to 2.5.35 as well as
numerous module updates and bugfixes.

Full lsm-2.5 patch (LSM + all modules) is available at:
	http://lsm.immunix.org/patches/2.5/2.5.35/patch-2.5.35-lsm1.gz

The whole ChangeLog for this release is at:
	http://lsm.immunix.org/patches/2.5/2.5.35/ChangeLog-2.5.35-lsm1

The LSM 2.5 BK tree can be pulled from:
        bk://lsm.bkbits.net/lsm-2.5

2.5.35-lsm1
 - merge with 2.5.31-35					(me)
 - fix dnotify_struct leak				(John Levon)
 - added hooks for labelling during TCP passive open	(Wayne Salamon)
 - LIDS: update file open permission; compile fixes.	(Huagang Xie)
 - SELinux: ipc_permission fix				(Stephen Smalley)
 - SELinux: selopt fixes				(Wayne Salamon)
 - SELinux: sysctl updates				(Stephen Smalley)
 - update TCP passive open hook				(Wayne Salamon)
 - SELinux: rework sock security field usage		(Wayne Salamon)
 - SELinux: __FUNCTION__ fixes				(Stephen Smalley)
 - SELinux: bug fixes (audit and constaint evaluation)	(Stephen Smalley)
 - LIDS: __FUNCTION__ fixes				(me)
 - DTE: update to proper tasklist locking and iterators (me)
 - LIDS: use new tasklist iterators			(me)

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
