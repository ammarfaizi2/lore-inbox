Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267282AbTAVC2Q>; Tue, 21 Jan 2003 21:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267284AbTAVC2Q>; Tue, 21 Jan 2003 21:28:16 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:28408 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S267282AbTAVC2P>; Tue, 21 Jan 2003 21:28:15 -0500
Date: Tue, 21 Jan 2003 18:37:11 -0800
From: Chris Wright <chris@wirex.com>
To: linux-security-module@wirex.com
Cc: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] 2.5.59-lsm1
Message-ID: <20030121183711.A9601@figure1.int.wirex.com>
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

2.5.59-lsm1 patch released.  This is a rebase up to 2.5.59 as well as
some minor interface and module updates.  Out of tree projects will want
to resync with interface changes.

Full lsm-2.5 patch (LSM + all modules) is available at:
	http://lsm.immunix.org/patches/2.5/2.5.59/patch-2.5.59-lsm1.gz

The whole ChangeLog for this release is at:
	http://lsm.immunix.org/patches/2.5/2.5.59/ChangeLog-2.5.59-lsm1

The LSM 2.5 BK tree can be pulled from:
        bk://lsm.bkbits.net/lsm-2.5

2.5.59-lsm1
 - merge with 2.5.53-59					(GregKH and me)
 - remove inode_post_lookup hook, add d_instantiate hook (Stephen Smalley)
 - email addr updates					(Stephen Smalley)
 - merge with mainline ipc updates			(me)
 - Fix ipc merge whitespace diffs			(Stephen Smalley)
 - DTE: fix compilation errors				(Stephen Smalley)
 - SELinux: restore sem_semop				(Stephen Smalley)

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
