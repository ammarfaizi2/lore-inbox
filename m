Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261309AbVFFMYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbVFFMYW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 08:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbVFFMYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 08:24:22 -0400
Received: from odin2.bull.net ([192.90.70.84]:26574 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S261309AbVFFMYT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 08:24:19 -0400
Subject: RT :  2.6.12rc5 + realtime-preempt-2.6.12-rc5-V0.7.47-15
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: BTS
Message-Id: <1118059968.10102.150.camel@ibiza.btsn.frna.bull.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-5.1.100mdk 
Date: Mon, 06 Jun 2005 14:12:49 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could someone explains me the following error with : hda: lost interrupt
What can I do ?
When hda error occurs, the was one RT process doing nothing with disks.

following the end od dmesg

 (     ksoftirqd/0-3    |#0): new 15 us maximum-latency wakeup.
 (     ksoftirqd/1-6    |#1): new 16 us maximum-latency wakeup.
 (     ksoftirqd/1-6    |#1): new 20 us maximum-latency wakeup.
 (     ksoftirqd/0-3    |#0): new 22 us maximum-latency wakeup.
 (            bash-11002|#0): new 30 us maximum-latency wakeup.
 (             gpm-5508 |#0): new 31 us maximum-latency wakeup.
 hda: dma_timer_expiry: dma status == 0x24
 hda: DMA interrupt recovery
 hda: lost interrupt
 (     ksoftirqd/0-3    |#0): new 33 us maximum-latency wakeup.
 (       desched/0-4    |#0): new 37 us maximum-latency wakeup.
 (     ksoftirqd/0-3    |#0): new 48 us maximum-latency wakeup.


