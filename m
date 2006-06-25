Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751247AbWFYNJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbWFYNJR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 09:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbWFYNJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 09:09:16 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:478 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1751247AbWFYNJP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 09:09:15 -0400
Message-ID: <351240952.20240@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060625130704.464870100@localhost.localdomain>
Date: Sun, 25 Jun 2006 21:07:04 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] Adaptive readahead updates 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Most patches here are focused on seperating out readahead overheads.

- apply after readahead-kconfig-options.patch
[PATCH 3/6] readahead: kconfig option READAHEAD_ALLOW_OVERHEADS
[PATCH 4/6] readahead: kconfig option READAHEAD_SMOOTH_AGING

- after readahead-context-based-method-fix-remain-counting.patch
[PATCH 1/6] readahead: context based method - slow start

- after readahead-backward-prefetching-method-add-use-case-comment.patch
[PATCH 2/6] readahead: backward prefetching method fix

- after readahead-call-scheme-no-fastcall-for-readahead_cache_hit.patch
[PATCH 5/6] readahead: kconfig option READAHEAD_HIT_FEEDBACK

- after readahead-remove-size-limit-on-read_ahead_kb.patch
[PATCH 6/6] readahead: remove the size limit of max_sectors_kb on read_ahead_kb


Thanks,
Fengguang Wu
-
Dept. Automation                University of Science and Technology of China
