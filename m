Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964867AbVJDRxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbVJDRxc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 13:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964866AbVJDRxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 13:53:32 -0400
Received: from ncc1701.cistron.net ([62.216.30.38]:18645 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP id S964867AbVJDRxb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 13:53:31 -0400
From: dth@cistron.nl (Danny ter Haar)
Subject: one liner segv with UP 2.6.14-rc3-git3
Date: Tue, 4 Oct 2005 17:53:29 +0000 (UTC)
Organization: Cistron
Message-ID: <dhufip$ptf$1@news.cistron.nl>
X-Trace: ncc1701.cistron.net 1128448409 26543 62.216.30.70 (4 Oct 2005 17:53:29 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@cistron.nl (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# procinfo
Linux 2.6.14-rc3-git3 (root@newsgate) (gcc 4.0.2 ) #1 Mon Oct 3 23:12:16 CEST 2005 1CPU [newsgate.(none)]

Memory:      Total        Used        Free      Shared     Buffers
Mem:       4062048     4034968       27080           0         628
Swap:            0           0           0

Bootup: Mon Oct  3 23:29:16 2005    Load average: 4.03 4.03 3.89 1/72 25128

user  :       2:14:51.81  11.1%  page in :        0
nice  :       0:20:22.90   1.7%  page out:        0
system:       6:03:52.77  29.8%  swap in :        0
idle  :       0:04:29.17   0.4%  swap out:        0
uptime:      20:19:23.89         context :201813317

irq  0:  18284554 timer                 irq 12:         3
irq  1:         8 i8042                 irq 16:  19195760 aic79xx
irq  4:      2575 serial                irq 17: 191052482 aic79xx, eth3
irq  9:         0 acpi                  irq 18: 337406813 acenic


produced this today:


sed[24842]: segfault at 0000000000000008 rip 00002aaaaaab4105 rsp 00007fffffae4a10 error 4

I believed these errors only happened in SMP environments ?

AMD64 - debian64bit


Danny

