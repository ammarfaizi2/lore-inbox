Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268414AbUHLF7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268414AbUHLF7V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 01:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268418AbUHLF7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 01:59:21 -0400
Received: from gizmo08bw.bigpond.com ([144.140.70.18]:9945 "HELO
	gizmo08bw.bigpond.com") by vger.kernel.org with SMTP
	id S268414AbUHLF7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 01:59:18 -0400
Message-ID: <411B0733.5080505@bigpond.net.au>
Date: Thu, 12 Aug 2004 15:59:15 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Michal Kaczmarski <fallow@op.pl>, spaminos-ker <spaminos-ker@yahoo.com>
Subject: [PATCH] V-4.1 Single Priority Array O(1) CPU Scheduler Evaluation
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 4.1 of the various single priority array scheduler patches for 
2.6.7 and 2.6.8-rc4 kernels are now available for evaluation.

This version contains a fix for a bug causing excessive promotion and an 
update of the staircase scheduler code to match Con's 7.I version.

1. [ZAPHOD] My proposed replacement scheduler which offers runtime 
selectable choice between a priority based or entitlement based O(1) 
scheduler with active/expired arrays replaced by  a single array and an 
O(1) promotion mechanism plus scheduling statistics with new simplified 
interactive bonus mechanism and throughput bonus mechanism:

2.6.7 
<http://prdownloads.sourceforge.net/cpuse/patch-2.6.7-spa_zaphod_FULL-v4.1?download> 
and/or 
<http://prdownloads.sourceforge.net/cpuse/patch-2.6.7-spa_zaphod-v4.0-to-v4.1?download>
2.6.8-rc4 
<http://prdownloads.sourceforge.net/cpuse/patch-2.6.8-rc4-spa_zaphod_FULL-v4.1?download>

2. [SC] Slightly modified version of Con Kolivas's staircase O(1) 
(version 7.I) scheduler with active/expired arrays replaced by a single 
array and an O(1)promotion mechanism:

2.6.7<http://prdownloads.sourceforge.net/cpuse/patch-2.6.7-spa_sc_FULL-v4.1?download> 
and/or 
<http://prdownloads.sourceforge.net/cpuse/patch-2.6.7-spa_sc-v4.0-to-v4.1?download>
2.6.8-rc4 
<http://prdownloads.sourceforge.net/cpuse/patch-2.6.8-rc4-spa_sc_FULL-v4.1?download>

3. [HYDRA] Runtime selection between staircase, priority based and
entitlement based O(1) schedulers:

2.6.7 
<http://prdownloads.sourceforge.net/cpuse/patch-2.6.7-spa_hydra_FULL-v4.1?download> 
and/or 
<http://prdownloads.sourceforge.net/cpuse/patch-2.6.7-spa_hydra-v4.0-to-v4.1?download>
2.6.8-rc3 
<http://prdownloads.sourceforge.net/cpuse/patch-2.6.8-rc4-spa_hydra_FULL-v4.1?download>

Other schedulers are also available from
<https://sourceforge.net/projects/cpuse/>

-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

