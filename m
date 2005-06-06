Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261554AbVFFTWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbVFFTWd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 15:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261639AbVFFTWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 15:22:33 -0400
Received: from fmr20.intel.com ([134.134.136.19]:2726 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261554AbVFFTWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 15:22:31 -0400
Message-Id: <20050606191433.104273000@araj-em64t>
Date: Mon, 06 Jun 2005 12:14:33 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Srivattsa Vaddagiri <vatsa@in.ibm.com>
Cc: discuss@x86-64.org
Cc: Rusty Russell <rusty@rustycorp.com.au>
Cc: Ashok Raj <ashok.raj@intel.com>
Subject: [patch 0/5] x86_64: try2: CPU hotplug patch series.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Attached are modified patch from zwane's feedback to earlier post.
Most of the other patches are pretty much the same, with no modifications.

Changes since last post.

- Removed call_lock before setting cpu_online_map
- Removed local_irq_disable() in play_dead() since safe_halt() enables it
  rightaway.

Cheers,
Ashok Raj

