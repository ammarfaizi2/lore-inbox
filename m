Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262320AbVFUWkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262320AbVFUWkr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 18:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbVFUWgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 18:36:10 -0400
Received: from fmr18.intel.com ([134.134.136.17]:46503 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S262320AbVFUWDl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 18:03:41 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: scheduler cache-hot-auto-tune patch breaks ia64 UP build
Date: Tue, 21 Jun 2005 15:03:51 -0700
Message-ID: <032EB457B9DBC540BFB1B7B519C78B0E076E3C6A@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: scheduler cache-hot-auto-tune patch breaks ia64 UP build
Thread-Index: AcV2rRuYz2dppFnrQO+/5rl+56XYXQ==
From: "Lynch, Rusty" <rusty.lynch@intel.com>
To: "Ingo Molnar" <mingo@elte.hu>, "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>
X-OriginalArrivalTime: 21 Jun 2005 22:03:30.0670 (UTC) FILETIME=[0F3860E0:01C576AD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attempting to build 2.6.12-mm1 on ia64 with CONFIG_SMP disabled will
cause the build to break because max_cache_size is undefined.  I haven't
spent the time to understand the cache-hot-auto-tune feature, so I don't
have a patch to fix the problem.

    --rusty
