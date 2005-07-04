Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261633AbVGDMCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261633AbVGDMCy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 08:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261643AbVGDMCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 08:02:54 -0400
Received: from [212.76.84.95] ([212.76.84.95]:62724 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S261633AbVGDMCX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 08:02:23 -0400
Message-Id: <200507041201.PAA26393@raad.intranet>
From: "Al Boldi" <a1426z@gawab.com>
To: "'Anton Blanchard'" <anton@samba.org>,
       "'Daniel Walker'" <dwalker@mvista.com>
Cc: <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] quieten OOM killer noise
Date: Mon, 4 Jul 2005 15:01:08 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <20050703173837.GB15055@krispykreme>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Thread-Index: AcV/9kXSRdtIPtp2Qfi4WQOVraCH8QAkCzUg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard wrote: {
Id suggest adding a printk level to the printks in mm/oom-kill.c and using
/proc/sys/kernel/printk to silence them.
}

Good option!

Also, why is OOM-killer needed when overcommit is disabled?

Al

