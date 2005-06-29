Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262326AbVF2RsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262326AbVF2RsZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 13:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261517AbVF2RsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 13:48:25 -0400
Received: from mail.tyan.com ([66.122.195.4]:20750 "EHLO tyanweb.tyan")
	by vger.kernel.org with ESMTP id S262326AbVF2RsS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 13:48:18 -0400
Message-ID: <3174569B9743D511922F00A0C94314230AF97420@TYANWEB>
From: YhLu <YhLu@tyan.com>
To: Andi Kleen <ak@suse.de>
Cc: Peter Buckingham <peter@pantasys.com>, linux-kernel@vger.kernel.org
Subject: 2.6.13-rc1 with dual way dual core ck804 MB
Date: Wed, 29 Jun 2005 10:52:06 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

I just tried 2.6.13-rc1, it hang on core0/node1 again.  there is some
interesting, it seems before the core1/node0 initialization is done, the
core0/node1 is started...

YH

Initializing CPU#1
masked ExtINT on CPU#1
Calibrating delay using timer specific routine.. 4423.00 BogoMIPS
(lpj=8846012)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1(2) -> Node 0 -> Core 1
 stepping 00
CPU 1: Syncing TSC to CPU 0.
Booting processor 2/2 rip 6000 rsp ffff81023ff1df58
Initializing CPU#2
masked ExtINT on CPU#2
CPU 1: synchronized TSC with CPU 0 (last diff 0 cycles, maxerr 595 cycles)
