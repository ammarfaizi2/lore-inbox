Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267397AbUBSWcL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 17:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267393AbUBSWcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 17:32:10 -0500
Received: from eik.ii.uib.no ([129.177.16.3]:9353 "EHLO eik.ii.uib.no")
	by vger.kernel.org with ESMTP id S267397AbUBSWb6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 17:31:58 -0500
Subject: Deadlocks and Machine Check Exception on Athlon64
From: "Ronny V. Vindenes" <s864@ii.uib.no>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1077229909.2828.22.camel@terminal124.gozu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.3 (1.5.3-1) 
Date: Thu, 19 Feb 2004 23:31:50 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My machine has been locking up [1] every now and then the last couple of
weeks and yesterday it locked during boot and I managed to copy this
message:

CPU 0: Machine Check Exception : 0000000000000004
Bank 4: b200000000070f0f
kernel panic: CPU context corrupt
In interrupt handler - not syncing

I tried to decode it with davej's parsemce, but it didn't produce any
usable output.

The machine is an MSI K8T Neo-FIS2R (flashed with 1.2 bios), with
Athlon64 3200+ and 2x512MB PC3200 DDR RAM, running 32bit 2.6.3-rc3-mm1
kernel. Any suggestions on what could be wrong?

[1] The lock-ups mostly happen during browsing with epiphany, I compile
a lot of big projects almost every day so it appears that cpu load or
memory use has no influence on the lock-ups.

-- 
Ronny V. Vindenes <s864@ii.uib.no>

