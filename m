Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751434AbWFIIMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbWFIIMv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 04:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWFIILZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 04:11:25 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:22426 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1751437AbWFIILX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 04:11:23 -0400
Message-ID: <349840678.03819@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060609080801.741901069@localhost.localdomain>
Date: Fri, 09 Jun 2006 16:08:01 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Adaptive readahead updates 2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Here are 5 small readahead patches collected in the past week.
They can be applied cleanly for linux-2.6.17-rc6-mm1.

- against readahead-state-based-method-routines.patch
	[PATCH 1/5] readahead: no RA_FLAG_EOF on single page file

- against readahead-initial-method-guiding-sizes.patch
	[PATCH 2/5] readahead: aggressive initial sizes

- against readahead-call-scheme.patch
	[PATCH 3/5] readahead: call scheme - no fastcall for readahead_cache_hit()

- standalone patches
	[PATCH 4/5] readahead: backoff on I/O error
	[PATCH 5/5] readahead: remove size limit on read_ahead_kb

Thanks,
Wu Fengguang
-
Dept. Automation                University of Science and Technology of China
