Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932187AbWE3Iq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbWE3Iq4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 04:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbWE3Iq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 04:46:56 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:24719 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S932187AbWE3Iqz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 04:46:55 -0400
Message-ID: <348978812.18213@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060530084030.274375770@localhost.localdomain>
Date: Tue, 30 May 2006 16:40:30 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [patch 0/4] Adaptive readahead patchset V14 updates
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

These are some fixes/updates for the adaptive readahead V14.

- apply stream_shift size limits to contexta method
- *remain in query_page_cache_segment() is over counted by 1, fix it
- add use case comment for backward prefetching

Please apply, thanks.

Wu
