Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268700AbUIQL2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268700AbUIQL2W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 07:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268698AbUIQL1B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 07:27:01 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:50402 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268697AbUIQL05 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 07:26:57 -0400
Date: Fri, 17 Sep 2004 04:25:33 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Jackson <pj@sgi.com>, Simon Derr <Simon.Derr@bull.net>,
       linux-kernel@vger.kernel.org
Message-Id: <20040917112534.32393.40435.59140@sam.engr.sgi.com>
In-Reply-To: <20040917112527.32393.49322.23478@sam.engr.sgi.com>
References: <20040917112527.32393.49322.23478@sam.engr.sgi.com>
Subject: cpusets: make CONFIG_CPUSETS the default in sn2_defconfig
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make CONFIG_CPUSETS enabled by default in sn2_defconfig.

Signed-off-by: Paul Jackson <pj@sgi.com>

Index: 2.6.9-rc2-mm1/arch/ia64/configs/sn2_defconfig
===================================================================
--- 2.6.9-rc2-mm1.orig/arch/ia64/configs/sn2_defconfig	2004-09-16 07:00:43.000000000 -0700
+++ 2.6.9-rc2-mm1/arch/ia64/configs/sn2_defconfig	2004-09-16 23:57:36.000000000 -0700
@@ -28,6 +28,7 @@ CONFIG_KALLSYMS_ALL=y
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
+CONFIG_CPUSETS=y
 CONFIG_IOSCHED_NOOP=y
 CONFIG_IOSCHED_AS=y
 CONFIG_IOSCHED_DEADLINE=y

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
