Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263305AbTFGRcN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 13:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263309AbTFGRcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 13:32:13 -0400
Received: from [65.198.37.67] ([65.198.37.67]:25524 "EHLO gghcwest.com")
	by vger.kernel.org with ESMTP id S263305AbTFGRcK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 13:32:10 -0400
Subject: SuSE 2.4.19-SMP x86_64 crashing on SCSI errors
From: "Jeffrey W. Baker" <jwb@gghcwest.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1055007945.28393.13.camel@heat>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 07 Jun 2003 10:45:46 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a machine where I can induce SCSI transmission errors by
configuring the bus for U320 operation.  Unfortunately this panics SuSE
2.4.19-SMP kernel on x86_64 with adaptec 39320D.  Stack:

timer_bh + 792
bh_action + 79
tasklet_hi_action + 139
do_softirq + 174
do_IRQ + 341
default_idle + 0
default_idle + 0
common_interrupt + 95
thread_return + 0
default_idle + 31
default_idle + 0
cpu_idle + 50

Code: unintelligible.  bummer.

-jwb

