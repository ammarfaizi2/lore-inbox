Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262333AbVGFW3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262333AbVGFW3v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 18:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262556AbVGFW2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 18:28:49 -0400
Received: from mail.tyan.com ([66.122.195.4]:18955 "EHLO tyanweb.tyan")
	by vger.kernel.org with ESMTP id S262548AbVGFWUW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 18:20:22 -0400
Message-ID: <3174569B9743D511922F00A0C94314230AF9783F@TYANWEB>
From: YhLu <YhLu@tyan.com>
To: Andi Kleen <ak@suse.de>
Cc: Peter Buckingham <peter@pantasys.com>, linux-kernel@vger.kernel.org
Subject: 2.6.13-rc2 with dual way dual core ck804 MB
Date: Wed, 6 Jul 2005 15:25:08 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

andi,

the core1/node0 take a long while to get TSC synchronized. Is it normal?
i guess 
"CPU 1: synchronized TSC with CPU 0"  should be just after "CPU 1: Syncing
TSC to CPU0"

YH


cpu 1: setting up apic clock
cpu 1: enabling apic timer
CPU 1: Syncing TSC to CPU 0.
CPU has booted.
waiting for cpu 1

cpu 2: setting up apic clock
cpu 2: enabling apic timer
CPU 2: Syncing TSC to CPU 0.
CPU 2: synchronized TSC with CPU 0 (last diff -4 cycles, maxerr 1097 cycles)
CPU has booted.
waiting for cpu 2

cpu 3: setting up apic clock
cpu 3: enabling apic timer
CPU 3: Syncing TSC to CPU 0.
CPU 3: synchronized TSC with CPU 0 (last diff 1 cycles, maxerr 1087 cycles)
CPU has booted.
waiting for cpu 3

testing NMI watchdog ... CPU#1: NMI appears to be stuck (1->1)!
checking if image is initramfs...<6>CPU 1: synchronized TSC with CPU 0 (last
diff 0 cycles, maxerr 595 cycles)
it isn't (no cpio magic); looks like an initrd


the 
