Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318235AbSGQHZN>; Wed, 17 Jul 2002 03:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318234AbSGQHZM>; Wed, 17 Jul 2002 03:25:12 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:21492 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S318233AbSGQHZK>; Wed, 17 Jul 2002 03:25:10 -0400
Date: Wed, 17 Jul 2002 00:26:35 -0700
From: Chris Wright <chris@wirex.com>
To: linux-security-module@wirex.com
Cc: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] 2.5.26-lsm1
Message-ID: <20020717002635.A17451@figure1.int.wirex.com>
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

2.5.26-lsm1 patch released.  This is a rebase to 2.5.26 as well as the
beginning of cleaning up for merging with mainline 2.5.

Full lsm-2.5 patch (LSM + all modules) is available at:
	http://lsm.immunix.org/patches/2.5/2.5.26/patch-2.5.26-lsm1.gz

The whole ChangeLog for this release is at:
	http://lsm.immunix.org/patches/2.5/2.5.26/ChangeLog-2.5.26-lsm1

The LSM 2.5 BK tree can be pulled from:
        bk://lsm.bkbits.net/lsm-2.5

2.5.26-lsm1
 - merge with 2.5.26					(me)
 - merge with 2.5.25					(James Morris)
 - LIDS cleanup						(me)
 - remove cruft leftover from fcntl_*lk* cleanup	(Stephen Smalley)
 - remove explicit Netfilter reliance			(James Morris)
 - reparent_to_init hook				(Stephen Smalley)
 - Flatten LSM hook structure				(James Morris)
 - various SELinux updates				(Stephen Smalley)

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
