Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261581AbVDJTNG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbVDJTNG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 15:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261583AbVDJTNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 15:13:05 -0400
Received: from smtp1.wanadoo.fr ([193.252.22.30]:29749 "EHLO smtp1.wanadoo.fr")
	by vger.kernel.org with ESMTP id S261581AbVDJTMt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 15:12:49 -0400
X-ME-UUID: 20050410191246639.9BFF61C00205@mwinf0109.wanadoo.fr
Subject: Is it possible to "reset" the processor to a sane state at boot?
From: Olivier Fourdan <fourdan@xfce.org>
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: http://www.xfce.org
Date: Sun, 10 Apr 2005 21:12:46 +0200
Message-Id: <1113160366.6102.30.camel@shuttle>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry if this post sounds a bit off topic now. It seems I've narrowed
down the issue with the timer running too fast on my AMD 64 based Compaq
laptop.

As said previously, after a cold restart, the system runs 3x too fast.
The processor speed as reported by both the Linux kernel and memtest86
is 266MHz while the lowest speed is actually 800MHz (1).

Even the BIOS shows that problem, instead of reporting the correct
800MHz speed for the CPU (like it does normally when the system is
fine), it shows "???MHz" at boot instead. So it's probably a hardware or
a BIOS issue (or both).

What is puzzling me is that doesn't make a single difference for WinXP.
Everything works just fine in WinXP (2). So I wonder, is there a way to
"reset" the processor to a sane state? If such a workaround is doable,
could someone point me to where I should look?

Thanks in advance

Olivier


(1) memtest86 uses "rdtsc" to compute cpu speed.
(2) The laptop came preloaded with WinXP and it runs fine with it, so I
guess that from a "support" point of view, the system is fine.



