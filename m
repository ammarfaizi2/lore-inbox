Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbULWHwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbULWHwk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 02:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbULWHwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 02:52:40 -0500
Received: from em.njupt.edu.cn ([202.119.230.11]:3203 "HELO njupt.edu.cn")
	by vger.kernel.org with SMTP id S261174AbULWHwj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 02:52:39 -0500
Message-ID: <303791597.15361@njupt.edu.cn>
X-WebMAIL-MUA: [10.10.136.115]
From: "Zhenyu Wu" <y030729@njupt.edu.cn>
To: linux-kernel@vger.kernel.org
Date: Thu, 23 Dec 2004 16:46:37 +0800
Reply-To: "Zhenyu Wu" <y030729@njupt.edu.cn>
X-Priority: 3
Subject: Kernel BUG at slab.c:1128!
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

when i am going to add some code in the linux kernel source code, i meet such
questions:

kernel BUG at slab.c: 1128

Kernel panic: Aiee, killing interrupt handler!
In interrupt handler -not syncing.

Reading from slab.c 1128, there is a check -in_interrupt(), have called some
fuctions in the interrupt handler?
But i just use "Kmalloc" to allocate some memory, is it the matter?


