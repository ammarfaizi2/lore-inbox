Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268642AbTBZEYl>; Tue, 25 Feb 2003 23:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268643AbTBZEYl>; Tue, 25 Feb 2003 23:24:41 -0500
Received: from dp.samba.org ([66.70.73.150]:34247 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S268642AbTBZEYk>;
	Tue, 25 Feb 2003 23:24:40 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Cc: mingo@redhat.com, mbligh@us.ibm.com
Subject: [BUG] 2.5.63: ESR killed my box!
Date: Wed, 26 Feb 2003 15:33:38 +1100
Message-Id: <20030226043457.8490E2C05D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SMP box, compiled for UP with CONFIG_LOCAL_APIC=y freezes on boot with
last lines:

	POSIX conformance testing by UNIFIX
	masked ExtINT on CPU#0
	ESR value before enabling vector: 00000008
	[ Freeze here ]

With SMP, it boots fine (then freezes mysteriously a few mins after
boot, which is what I am still chasing):

	masked ExtINT on CPU#0
	ESR value before enabling vector: 00000000
	ESR value after enabling vector: 00000000
	...

Don't know exactly what kernel this first happened, I usually run SMP.

Clues?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
