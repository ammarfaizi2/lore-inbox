Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269088AbUINCeV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269088AbUINCeV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 22:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269127AbUINCcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 22:32:24 -0400
Received: from dialup-4.246.108.250.Dial1.SanJose1.Level3.net ([4.246.108.250]:48001
	"EHLO nofear.bounceme.net") by vger.kernel.org with ESMTP
	id S269088AbUINC1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 22:27:20 -0400
Reply-To: <syphir@syphir.sytes.net>
From: "C.Y.M." <syphir@syphir.sytes.net>
To: <linux-kernel@vger.kernel.org>
Subject: Changes to ide-probe.c in 2.6.9-rc2 causing improper detection
Date: Mon, 13 Sep 2004 19:26:56 -0700
Organization: CooLNeT
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA9mKu6AlYok2efOpJ3sb3O+KAAAAQAAAAjtLAU+gqyUq8AePOBiNtXQEAAAAA@syphir.sytes.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcSaAk3OA4DP+/YLTbOwKT0twXRKjw==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After installing 2.6.9-rc2 on my PC today (x86 VIA Chipset motherboard and
Athlon XP CPU), The IDE detection during boot in probing for ide2-5 and
displaying errors, and the hard drives that it does find are telling me that
"hda: cache flushes not supported" (when they are displayed as supported
when using 2.6.9-rc1.

