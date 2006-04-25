Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751588AbWDYQjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588AbWDYQjL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 12:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751601AbWDYQjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 12:39:10 -0400
Received: from www.osadl.org ([213.239.205.134]:45184 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751587AbWDYQjK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 12:39:10 -0400
Message-Id: <20060425162414.896662000@localhost.localdomain>
Date: Tue, 25 Apr 2006 16:41:04 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
Subject: [patch 0/4] futex-pi updates
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

please apply the following updates to the futex-pi code in 2.6.17-rc1-mm3:

- Remove buggy BUG_ON in the PI boosting code
- Enforce waiter bit in owner died situations
- Printk output fixlet
- Add restart handling for interrupted futex_pi lock operations

	tglx

--

