Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264551AbTFQFOI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 01:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264569AbTFQFOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 01:14:08 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:10486 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id S264551AbTFQFOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 01:14:05 -0400
Date: Mon, 16 Jun 2003 22:27:12 -0700
From: Chris Wright <chris@wirex.com>
To: linux-security-module@wirex.com
Cc: linux-kernel@vger.kernel.org
Subject: 2.5.71-lsm1
Message-ID: <20030616222712.C15289@figure1.int.wirex.com>
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

2.5.71-lsm1 patch released.  This is an update up to 2.5.71 as well as
some module updates, and various cleanups.  In line with other struct
sock changes in 2.5.71, the sock->security field is now called
sk_security.

Full lsm-2.5 patch (LSM + all modules) is available at:
	http://lsm.immunix.org/patches/2.5/2.5.71/patch-2.5.71-lsm1.gz

The whole ChangeLog for this release is at:
	http://lsm.immunix.org/patches/2.5/2.5.71/ChangeLog-2.5.71-lsm1

The LSM 2.5 BK tree can be pulled from:
        bk://lsm.bkbits.net/lsm-2.5

ChangeLog summary:

Chris Wright:
  o [SELINUX] update to new struct sock (struct members now prefixed with sk_)
    TAG: v2.5.71-lsm1
  o [LIDS] update to new struct sock (struct members now prefixed with sk_)
  o update to new struct sock (->security becomes ->sk_security)
  o trigger update.  Update to newer SendMail.pm, and set ReplyTo
  o merge with 2.5.71
  o [TPE] various cleanups
  o [LIDS] delete lids_check_scan.c, leftover from previous lids patch

Huagang Xie:
  o [LIDS] merge 2.0.3rc1 patch

Niki Rahimi:
  o [TPE] Update doc to reflect use of sysfs
  o [TPE] move to sysfs and fix bug in tpe_search
  o Updates to spin lock code
  o Added spin locks to tpe_acl

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
