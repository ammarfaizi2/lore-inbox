Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275233AbTHRW6Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 18:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275235AbTHRW6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 18:58:24 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:57605 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S275233AbTHRW6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 18:58:23 -0400
Subject: Hang at i8042.c when booting with no PS/2 mouse attached
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: vojtech@suse.cz
Content-Type: text/plain
Message-Id: <1061247500.625.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 19 Aug 2003 00:58:20 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On my Intel i845DE Pentium IV box, trying to boot 2.6.0-test3-bk6 while
no PS/2 mouse is plugged in, causes the kernel to hang while trying to
call request_irq() inside i8042_check_aux() function in module i8042.c.

Further details for this bug are at:

http://bugzilla.kernel.org/show_bug.cgi?id=1123

Thanks!

