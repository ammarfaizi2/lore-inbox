Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266694AbUFXRY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266694AbUFXRY2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 13:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266697AbUFXRY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 13:24:27 -0400
Received: from main.gmane.org ([80.91.224.249]:899 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266694AbUFXRYP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 13:24:15 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joshua Kwan <jkwan@rackable.com>
Subject: [HELP] Tracking down a MD bug
Date: Thu, 24 Jun 2004 10:24:19 -0700
Message-ID: <pan.2004.06.24.17.24.17.353731@rackable.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 64-60-248-66.cust.telepacific.net
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've been running benchmarks on a ~2TB software RAID array of varying
configurations using SuSE Linux 9.1's kernel 2.6.4-52-smp. I noticed that
while resyncing a newly created RAID 5 array the kernel would just hang
a few seconds after starting.

I compiled 2.6.7-mm1 just now and the RAID array is busy resyncing, and
still alive, right now.

Are there any MD code changes that could have caused this so I can point
SuSE somewhere? (Well, then again, many SuSE folks are on this list anyway...)

This is on the x86_64 architecture, highmem + SMP + SATA RAID adapter
(although I'm not using it in hardware mode.) I'll provide config/dmesg
from the old kernel on request.

Thanks,

-- 
Joshua Kwan


