Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266304AbUHBGc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266304AbUHBGc1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 02:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266306AbUHBGc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 02:32:27 -0400
Received: from gizmo02ps.bigpond.com ([144.140.71.12]:32224 "HELO
	gizmo02ps.bigpond.com") by vger.kernel.org with SMTP
	id S266304AbUHBGcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 02:32:00 -0400
Message-ID: <410DDFD2.5090400@bigpond.net.au>
Date: Mon, 02 Aug 2004 16:31:46 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Michal Kaczmarski <fallow@op.pl>, Shane Shrybman <shrybman@aei.ca>
Subject: [PATCH] V-3.0 Single Priority Array O(1) CPU Scheduler Evaluation
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 3 of the various single priority array scheduler patches for 
2.6.7, 2.6.8-rc2 and 2.6.8-rc2-mm1 kernels are now available for 
download and evaluation:

1. Standard O(1) scheduler with active/expired arrays replaced by a 
single array and an O(1) promotion mechanism plus scheduling statistics:

2.6.7 
<http://prdownloads.sourceforge.net/cpuse/patch-2.6.7-spa_trad_FULL-v3.0?download>
2.6.8-rc2 
<http://prdownloads.sourceforge.net/cpuse/patch-2.6.8-rc2-spa_trad_FULL-v3.0.1?download>
2.6.8-rc2-mm1 
<http://prdownloads.sourceforge.net/cpuse/patch-2.6.8-rc2_mm1-spa_trad_FULL-v3.0?download>

2. Basic O(1) scheduler with active/expired arrays replaced by a single 
array and an O(1) promotion mechanism plus scheduling statistics with 
all interactive bonus etc. removed:

2.6.7 
<http://prdownloads.sourceforge.net/cpuse/patch-2.6.7-spa_base_FULL-v3.0?download>
2.6.8-rc2 
<http://prdownloads.sourceforge.net/cpuse/patch-2.6.8-rc2-spa_base_FULL-v3.0.1?download>
2.6.8-rc2-mm1 
<http://prdownloads.sourceforge.net/cpuse/patch-2.6.8-rc2_mm1-spa_base_FULL-v3.0?download>

3. Priority based O(1) scheduler with active/expired arrays replaced by 
a single array and an O(1) promotion mechanism plus scheduling 
statistics with new interactive bonus mechanism and throughput bonus 
mechanism:

2.6.7 
<http://prdownloads.sourceforge.net/cpuse/patch-2.6.7-spa_pb_FULL-v3.0?download>
2.6.8-rc2 
<http://prdownloads.sourceforge.net/cpuse/patch-2.6.8-rc2-spa_pb_FULL-v3.0.1?download>
2.6.8-rc2-mm1 
<http://prdownloads.sourceforge.net/cpuse/patch-2.6.8-rc2_mm1-spa_pb_FULL-v3.0?download>

4. Runtime selectable choice between a priority based or entitlement 
based O(1) scheduler with active/expired arrays replaced by a single 
array and an O(1) promotion mechanism plus scheduling statistics with 
new interactive bonus mechanism and throughput bonus mechanism:

2.6.7 
<http://prdownloads.sourceforge.net/cpuse/patch-2.6.7-spa_zaphod_FULL-v3.0?download>
2.6.8-rc2 
<http://prdownloads.sourceforge.net/cpuse/patch-2.6.8-rc2-spa_zaphod_FULL-v3.0.1?download>
2.6.8-rc2-mm1 
<http://prdownloads.sourceforge.net/cpuse/patch-2.6.8-rc2_mm1-spa_zaphod_FULL-v3.0?download>

5. Slightly modified version of Con Kolivas's staircase O(1) scheduler 
with active/expired arrays replaced by a single array and an O(1) 
promotion mechanism:

2.6.7 
<http://prdownloads.sourceforge.net/cpuse/patch-2.6.7-spa_sc_FULL-v3.0?download>
2.6.8-rc2 
<http://prdownloads.sourceforge.net/cpuse/patch-2.6.8-rc2-spa_sc_FULL-v3.0.1?download>
2.6.8-rc2-mm1 
<http://prdownloads.sourceforge.net/cpuse/patch-2.6.8-rc2_mm1-spa_sc_FULL-v3.0?download>

6. Runtime selection between staircase, priority based and entitlement 
based O(1) schedulers:

2.6.7 
<http://prdownloads.sourceforge.net/cpuse/patch-2.6.7-spa_hydra_FULL-v3.0?download>
2.6.8-rc2 
<http://prdownloads.sourceforge.net/cpuse/patch-2.6.8-rc2-spa_hydra_FULL-v3.0.1?download>
2.6.8-rc2-mm1 
<http://prdownloads.sourceforge.net/cpuse/patch-2.6.8-rc2_mm1-spa_hydra_FULL-v3.0?download>

7. Standard O(1) scheduler with scheduling statistics added:

2.6.7 
<http://prdownloads.sourceforge.net/cpuse/patch-2.6.7-stats-v3.0?download>
2.6.8-rc2 
<http://prdownloads.sourceforge.net/cpuse/patch-2.6.8-rc2-stats-v3.0.1?download>
2.6.8-rc2-mm1 
<http://prdownloads.sourceforge.net/cpuse/patch-2.6.8-rc2_mm1-stats-v3.0?download>

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

