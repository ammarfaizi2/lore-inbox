Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751846AbVHGO32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846AbVHGO32 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 10:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751847AbVHGO32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 10:29:28 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:64674 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1751846AbVHGO31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 10:29:27 -0400
From: kernel-stuff@comcast.net (Parag Warudkar)
To: Andi Kleen <ak@suse.de>, Erick Turnquist <jhujhiti@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Lost Ticks on x86_64
Date: Sun, 07 Aug 2005 14:29:16 +0000
Message-Id: <080720051429.26355.42F61ABC0005F4BA000066F3220699849900009A9B9CD3040A029D0A05@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Dec 17 2004)
X-Authenticated-Sender: a2VybmVsLXN0dWZmQGNvbWNhc3QubmV0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No way to fix this, but you can work around it with very new kernels
> by compiling with a lower HZ than 1000.

John Stultz's timeofday patches seem to fix this lost ticks issue.  You might want to try them.

(I too, routinely get "lost ticks - rip is at acpi_processor_idle" messages which vanished during the period when I was trying John's patches.)

Parag



