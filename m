Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262100AbTDAH0m>; Tue, 1 Apr 2003 02:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262103AbTDAH0m>; Tue, 1 Apr 2003 02:26:42 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:4086 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S262100AbTDAH0l>; Tue, 1 Apr 2003 02:26:41 -0500
Date: Mon, 31 Mar 2003 23:35:48 -0800
From: Chris Wright <chris@wirex.com>
To: linux-security-module@wirex.com
Cc: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] 2.5.66-lsm1
Message-ID: <20030331233548.A7582@figure1.int.wirex.com>
Mail-Followup-To: linux-security-module@wirex.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux Security Modules project provides a lightweight, general purpose
framework for access control.  The LSM interface enables developing
security policies as loadable kernel modules.  See http://lsm.immunix.org
for more information.

2.5.66-lsm1 patch released.  This is a rebase up to 2.5.66 as well as
some interface and module updates.  Out of tree projects will want to
resync with interface changes.

Full lsm-2.5 patch (LSM + all modules) is available at:
	http://lsm.immunix.org/patches/2.5/2.5.66/patch-2.5.66-lsm1.gz

The whole ChangeLog for this release is at:
	http://lsm.immunix.org/patches/2.5/2.5.66/ChangeLog-2.5.66-lsm1

The LSM 2.5 BK tree can be pulled from:
        bk://lsm.bkbits.net/lsm-2.5

2.5.66-lsm1
 - merge with 2.5.59-66					(me)
 - restore file permission hooks to sendfile		(Stephen Smalley)
 - security.h inclusion in network files		(Stephen Smalley)
 - cleanup init[open]_private_file			(Stephen Smalley)
 - syslog, sysctl cleanups				(Stephen Smalley)
 - add CONFIG_SECURITY_NETWORK				(Stephen Smalley)
 - cleanup for newer skb allocation			(me)
 - SELinux:						(Stephen Smalley)
   - labelled network fixes
   - ptrace fixes, drop support for exec_permission_lite
   - minor fixes
   - use kernel SID in reparent_to_init
 - drop task_kmod_set_label hook			(me)
 - drop explicit exec_permission_lite hook		(me)
 - drop exta call to security_sock_rcv_skb hook		(me)
 - fix setfs[ug]id return values			(Jakub Jelinek)

thanks,
-chris

-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
