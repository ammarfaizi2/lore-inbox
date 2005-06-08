Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262080AbVFHDOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbVFHDOh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 23:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262082AbVFHDOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 23:14:30 -0400
Received: from fmr20.intel.com ([134.134.136.19]:62873 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S262080AbVFHDN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 23:13:58 -0400
Message-Id: <20050608030901.001736000@araj-em64t>
Date: Tue, 07 Jun 2005 20:09:01 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Srivattsa Vaddagiri <vatsa@in.ibm.com>,
       Shaohua Li <shaohua.li@intel.com>,
       Rusty Russell <rusty@rustycorp.com.au>, Ashok Raj <ashok.raj@intel.com>
Subject: [patch 0/2] i386: CPU hotplug related patch series
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew

Following series is replica of what i did for x86_64.

- Remove broadcast IPI for flat mode when CPU hotplug is enabled.
- Add option to choose broadcast or mask version via command line.
- hold call_lock to exclude upcomming cpu during a smp_call_function()
  progress.

Cheers,
Ashok Raj

