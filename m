Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266630AbUF3MSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266630AbUF3MSm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 08:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266644AbUF3MSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 08:18:42 -0400
Received: from aun.it.uu.se ([130.238.12.36]:22686 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S266630AbUF3MSk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 08:18:40 -0400
Date: Wed, 30 Jun 2004 14:18:30 +0200 (MEST)
Message-Id: <200406301218.i5UCIU8l014011@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.7-mm4] perfctr update: summary
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

This set of patches should address most of perfctr's
coding issues that you've noted recently.

I'll start writing documentation on the low-level
drivers today.

The parts that follow are:

1/6: fix CONFIG_PERFCTR_INIT_TESTS && !CONFIG_X86_LOCAL_APIC
     linkage error
2/6: Kconfig-related updates
3/6: add __user annotations
4/6: PPC32 cleanups
5/6: reduce stack usage
6/6: misc minor cleanups

/Mikael
