Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270191AbUJTEpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270191AbUJTEpE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 00:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264530AbUJTEnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 00:43:43 -0400
Received: from gizmo02bw.bigpond.com ([144.140.70.12]:37345 "HELO
	gizmo02bw.bigpond.com") by vger.kernel.org with SMTP
	id S267536AbUJTEmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 00:42:03 -0400
Message-ID: <4175EC97.5060804@bigpond.net.au>
Date: Wed, 20 Oct 2004 14:41:59 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Michal Kaczmarski <fallow@op.pl>, Shane Shrybman <shrybman@aei.ca>
Subject: [PATCH] V-6.0 ZAPHOD Single Priority Array O(1) CPU Scheduler
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 6.0 of the ZAPHOD single priority array scheduler patches for 
the 2.6.9 kernel are now available for download and evaluation from:

<http://prdownloads.sourceforge.net/cpuse/patch-2.6.9-spa_zaphod_FULL-v6.0?download>

Notes on ZAPHOD's features are available at:

<https://sourceforge.net/project/shownotes.php?group_id=112404&release_id=273135>

This is the first stage of a code reorganization that moves as much new 
code as possible out of sched.c into separate source files in order to 
make it easier to implement alternative (to ZAPHOD) single priority 
array (SPA) schedulers on top of the SPA base.  As a consequence, the 
other SPA schedulers (e.g. HYDRA) are not yet available for 2.6.9 and 
will probably not be available for several days.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
