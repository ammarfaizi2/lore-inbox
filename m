Return-Path: <linux-kernel-owner+w=401wt.eu-S932155AbXAKXL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbXAKXL0 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 18:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932657AbXAKXL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 18:11:26 -0500
Received: from mail.screens.ru ([213.234.233.54]:38906 "EHLO mail.screens.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932155AbXAKXLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 18:11:25 -0500
Date: Fri, 12 Jan 2007 02:10:01 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Srivatsa Vaddagiri <vatsa@in.ibm.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Gautham shenoy <ego@in.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       David Howells <dhowells@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] workqueue: cpu-hotplug fixes
Message-ID: <20070111231001.GA2978@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This series is not tested, 2.6.20-rc3-mm1 panics on boot for me, please review.
It tries to fix all known cpu-hotplug related problems in workqueue.c.

These problems are old, they were not introduced by recent changes. I strongly
beleive we can't fix them if we change cpu-hotplug to use freezer.

Oleg.

