Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262737AbTFZTT2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 15:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262874AbTFZTT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 15:19:27 -0400
Received: from slimnet.xs4all.nl ([194.109.194.192]:2022 "EHLO gatekeeper.slim")
	by vger.kernel.org with ESMTP id S262737AbTFZTTX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 15:19:23 -0400
Subject: No HT without ACPI?
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1056656002.3845.10.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-1) 
Date: 26 Jun 2003 21:33:22 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I had to disable ACPI on my system because it caused a high
load. While rebooting I noticed that the second CPU (P4 HT) wasn't
found:

CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU0: Intel(R) Pentium(R) 4 CPU 2.60GHz stepping 09
per-CPU timeslice cutoff: 1462.79 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Error: only one processor found.
WARNING: No sibling found for CPU 0.
ENABLING IO-APIC IRQs

Is ACPI necessary for HT to work? This is with 2.4.21.

Cheers,

Jurgen



