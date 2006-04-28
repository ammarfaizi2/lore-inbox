Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030259AbWD1BlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030259AbWD1BlV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 21:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030252AbWD1BiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 21:38:11 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:59629 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030243AbWD1BiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 21:38:06 -0400
From: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
Cc: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
Date: Fri, 28 Apr 2006 10:37:30 +0900
Message-Id: <20060428013730.9582.9351.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
Subject: [PATCH 0/9] CPU controller
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

This patchset adds a CPU resource controller on top of Resource Groups. 
The CPU resource controller manages CPU resources by scaling timeslice
allocated for each task without changing the algorithm of the O(1)
scheduler.

Please consider these for inclusion in -mm tree.
--
Patch descriptions:

1/9: cpurc_load_estimation
	- Adds class load estimation support

2/9: cpurc_hungry_detection
	- Adds class hungry detection support

3/9: cpurc_timeslice_scaling
	- Adds CPU resource controll by scaling timeslice

4/9: cpurc_interface
	- Adds interface functions to CKRM CPU controller

5/9: cpurc_docs
	- Documentation how the CPU resource controller works 

6/9: cpu_init
	- Adds the basic functions and registering the CPU controller
	  on top of Resource Groups

7/9: cpu_shares_n_stats
	- Adds routines to change share values and show statistics

8/9: cpu_hotplug
	- Adds cpu hotplug support 

9/9: cpu_docs
	- Documentation how to use the CPU controller

Thanks,
MAEDA Naoaki
