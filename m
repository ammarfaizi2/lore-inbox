Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265489AbUFCDwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265489AbUFCDwe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 23:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265490AbUFCDwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 23:52:34 -0400
Received: from mailout.despammed.com ([65.112.71.29]:33974 "EHLO
	mailout.despammed.com") by vger.kernel.org with ESMTP
	id S265489AbUFCDwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 23:52:33 -0400
Date: Wed, 2 Jun 2004 22:39:17 -0500 (CDT)
Message-Id: <200406030339.i533dHk07037@mailout.despammed.com>
From: ndiamond@despammed.com
To: linux-kernel@vger.kernel.org
Subject: MIPS, How to use floating point in a module?
X-Mailer: despammed.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now I am told that our next target will be a MIPS-based CPU.
Looking at files under arch and asm includes for MIPS, I don't see
any equivalent of the x86 (x87, 686, etc.) functions and macros
kernel_fpu_begin, init_fpu, kernel_fpu_end, etc.  Is it safe to
just barge ahead and use floating-point arithmetic operators when
the driver needs to use them?

This CPU has no opcodes for log2, exp2, sin, and cos, so it looks
like I'll have to buy one of the books that some posters here kindly
recommended, and do polynomial interpolations.

