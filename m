Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261912AbUC0XDp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 18:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbUC0XDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 18:03:45 -0500
Received: from fep02-mail.bloor.is.net.cable.rogers.com ([66.185.86.72]:15374
	"EHLO fep02-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S261912AbUC0XDn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 18:03:43 -0500
From: "Shawn Starr" <shawn.starr@rogers.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.6.x strangeness with large buffer usage via network transfer/disk and SEGV processes
Date: Sat, 27 Mar 2004 18:07:38 -0500
Message-ID: <000001c41450$4c6c1f30$030aa8c0@PANIC>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at fep02-mail.bloor.is.net.cable.rogers.com from [67.60.40.239] using ID <shawn.starr@rogers.com> at Sat, 27 Mar 2004 18:02:37 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't get something maybe someone can explain why this is happening:

1) When using a large amount of buffers via sending say a 800MB file from
one PC to another, the Linux system will segfault processes but not preform
an OOM. Even though the system itself has not touched swap memory. Why is
the kernel killing/or why are the processes dying with Segfault?

I see this happening when I extract a Linux source tarball and have certain
processes running, while tar extracts the process will just receive a
segmentation fault w/o core.

When using a virtual OS emulator, the emulator will just die.

I don't remember this behaviour in 2.4 at all and I don't think this is
correct. I have PREEMPT enabled as well.

Is this a problem or is this correct behavour?

Thanks

Shawn S.

