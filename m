Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbTHYSBB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 14:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262004AbTHYSBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 14:01:00 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:36727 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S262001AbTHYSA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 14:00:59 -0400
Subject: 2.6.0test4 ACPI with nForce2 success
From: "Trever L. Adams" <tadams-lists@myrealbox.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1061834424.2599.2.camel@aurora.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Mon, 25 Aug 2003 14:00:56 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been one of these people who have been having to boot with
pci=noacpi to get up with much of my hardware initialized.  My system is
now working without it.  It isn't getting shutoff on irq storms or
anything.

My only possible problem is this:

 13:59:40  up 8 min,  3 users,  load average: 0.86, 0.81, 0.36
           CPU0
  0:     516847          XT-PIC  timer

I am not sure how fast the irq's for the timer should be going up.  So,
that may be an issue.

I am aware some of these changes are causing problems for others, but
they fixed the mess for me.

Thank you.

Trever
--
"He who chops his own wood, is warm twice." -- Abraham Lincoln

