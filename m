Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271285AbTGQQXR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 12:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271295AbTGQQXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 12:23:17 -0400
Received: from d12lmsgate.de.ibm.com ([194.196.100.234]:16276 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S271285AbTGQQXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 12:23:14 -0400
Date: Thu, 17 Jul 2003 18:36:56 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 2.6.0-test1: description.
Message-ID: <20030717163656.GA2045@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
some more bug fixes for s390. 6 patches against linux-bk as of 2003/07/17.

Short descriptions:
1) Some minor stuff in arch/s390 and include/asm-s390.
2) Enable irq statistics for s390*. While we can't keep stats for all
   i/o interrupts (65536) and external interrupts (4), we can count
   all i/o interrupts and all external interrupts as two classes of
   interrupts.
3) Remove surplus put_disk in the dasd driver.
4) Common i/o layer fixes.
5) Qeth network driver fixes.
6) Correct size of siginfo_t for s390x.

blue skies,
  Martin.

