Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932369AbVI2XKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbVI2XKT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 19:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbVI2XKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 19:10:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1418 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751356AbVI2XKQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 19:10:16 -0400
Date: Thu, 29 Sep 2005 16:10:11 -0700
From: Chris Wright <chrisw@osdl.org>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PATCH] LSM update, missing hook
Message-ID: <20050929231011.GM7991@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/chrisw/lsm-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/chrisw/lsm-2.6.git/

This has one small fix in it:

 fs/read_write.c |    3 +++
 1 files changed, 3 insertions(+)

Kostik Belousov:
  readv/writev syscalls are not checked by lsm
