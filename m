Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030216AbVLMUzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030216AbVLMUzr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 15:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030219AbVLMUzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 15:55:47 -0500
Received: from fmr23.intel.com ([143.183.121.15]:27807 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1030216AbVLMUzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 15:55:46 -0500
Message-Id: <20051213203547.649087523@csdlinux-2.jf.intel.com>
Date: Tue, 13 Dec 2005 12:35:47 -0800
From: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
To: ananth@in.ibm.com, akpm@osdl.org, paulmck@us.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: [patch 0/4] Kprobes cleanup patches 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are the set of patches tagged to this mail.
1)Subject: Kprobes - Enable funcions only for required arch
	This is a cleanup patch
2)Subject: Kprobes - cleanup include_asm_kprobes_h
	This is a cleanup patch
3)Subject: Kprobes - Changed from using spinlock to mutext
	This patch is a improvement patch which now
		uses mutex over spinlock for 
	registration/unregistration code path.
4)Subject: Kprobes Cleanup arch_remove_kprobe
	This is a cleanup patch

More description inside the patch itself.

Andrew, please include these in your mm tree.

thanks,
Anil Keshavamurthy


--

