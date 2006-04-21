Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbWDUC2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbWDUC2n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 22:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbWDUC2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 22:28:42 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:52711 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932133AbWDUC2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 22:28:17 -0400
From: maeda.naoaki@jp.fujitsu.com
To: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Cc: maeda.naoaki@jp.fujitsu.com
Date: Fri, 21 Apr 2006 11:27:27 +0900
Message-Id: <20060421022727.13598.15397.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
Subject: [RFC][PATCH 0/9] CKRM CPU resource controller
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds a CPU resource controller for CKRM.  The CPU
resource controller manages CPU resources by scaling timeslice
allocated for each task without changing the algorithm of the O(1)
scheduler.

Patch descriptions:
1/9: cpurc_load_estimation
	- Adds class load estimation

2/9: cpurc_hungry_detection
	- Adds class hungry detection

3/9: cpurc_timeslice_scaling
	- Adds CPU resource controll by scaling timeslice

4/9: cpurc_interface
	- Adds interface functions to CKRM CPU controller

5/9: cpurc_docs
	- Documents how the CPU resource controller works 

6/9: ckrm_cpu_init
	- Adds the basic functions and registering the CPU controller
	  to CKRM

7/9: ckrm_cpu_shares_n_stats
	- Adds routines to change share values and show statistics

8/9: ckrm_cpu_hotplug
	- Adds cpu hotplug notifier for the CPU controller

9/9: ckrm_cpu_docs
	- Documents how to use the CPU controller

Thanks,
MAEDA Naoaki
