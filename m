Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262507AbUKWLXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262507AbUKWLXS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 06:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262514AbUKWLXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 06:23:18 -0500
Received: from mf2.realtek.com.tw ([220.128.56.22]:48136 "EHLO
	mf2.realtek.com.tw") by vger.kernel.org with ESMTP id S262507AbUKWLXP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 06:23:15 -0500
Message-ID: <011501c4d14e$d00b1ce0$8b1a13ac@realtek.com.tw>
From: "colin" <colin@realtek.com.tw>
To: <linux-kernel@vger.kernel.org>
Subject: I cannot stop execution by using "ctrl+c"
Date: Tue, 23 Nov 2004 19:23:10 +0800
MIME-Version: 1.0
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
X-MIMETrack: Itemize by SMTP Server on msx/Realtek(Release 6.0.2CF1|June 9, 2003) at
 2004/11/23 =?Bog5?B?pFWkyCAwNzoyNDozMA==?=,
	Serialize by Router on msx/Realtek(Release 6.0.2CF1|June 9, 2003) at 2004/11/23
 =?Bog5?B?pFWkyCAwNzoyNDozMQ==?=,
	Serialize complete at 2004/11/23 =?Bog5?B?pFWkyCAwNzoyNDozMQ==?=
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset="big5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,
When using gdb to debug Linux kernel, I found that it cannot be stopped
temporarily by using "ctrl+c".
After the first strike of "ctrl+c", nothing happen.
After the second, Linux kernel will show these messages:
    Interrupted while waiting for the program.
    Give up (and stop debugging it)? (y or n)
If choose yes, kernel will totally stop and it goes back to gdb shell.
How can I stop kernel temporarily and then resume it?

Thanks and regards,
Colin

