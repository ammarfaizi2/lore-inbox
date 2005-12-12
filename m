Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750954AbVLLAqD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbVLLAqD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 19:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750956AbVLLAqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 19:46:03 -0500
Received: from w241.dkm.cz ([62.24.88.241]:2452 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750954AbVLLAqB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 19:46:01 -0500
From: Petr Baudis <pasky@suse.cz>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] Link lxdialog with mconf directly
Date: Mon, 12 Dec 2005 01:41:59 +0100
To: zippel@linux-m68k.org
Cc: sam@ravnborg.org, kbuild-devel@lists.sourceforge.net
Message-Id: <20051212004159.31263.89669.stgit@machine.or.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  The following series revives one three years old patch, turning lxdialog
to a library and linking it directly to mconf, making menuconfig nicer and
things in general quite simpler and cleaner.

  The first two patches make slight adjustements to kbuild in order to make
liblxdialog possible. The third patch does the libification itself and
appropriate modifications to mconf.c.

  PS: Sorry for the blank covermail I've sent before. StGIT still seems
to behave, er.. erratically.

				Petr Baudis

-- 
And on the eigth day, God started debugging.
