Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262058AbUCJAuK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 19:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbUCJAuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 19:50:10 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:1445 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262058AbUCJAuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 19:50:06 -0500
Date: Wed, 10 Mar 2004 09:50:00 +0900
From: Norihiko Mukouyama <norihiko_m@jp.fujitsu.com>
Subject: RE: Kernel 2.6.3 patch for Intel Compiler 8.0
In-reply-to: <000001c40635$2d4841c0$374ca8c0@bunnybook2>
To: Ingo at Pyrillion <ingo@pyrillion.org>,
       "'Norberto Bensa'" <norberto+linux-kernel@bensa.ath.cx>
Cc: linux-kernel@vger.kernel.org
Message-id: <FLEBKJHLJPMMOPBNJGELCEMMCNAA.norihiko_m@jp.fujitsu.com>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Content-type: text/plain;	charset="iso-8859-1"
Content-transfer-encoding: 7bit
Importance: Normal
X-Priority: 3 (Normal)
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All!!

>I used the patch to compile two identical kernels with gcc 3.3.3 and
>icc 8.0 with oprofile support built in.
>The optimization switches were chosen quite conservative, i.e.
>"-O2 -Ob1", no IPO, and of course: no MMX, SSE, and SSE2 stuff inside
>the kernel (thus disabling Intel's great vectorizer).
>Profiling: lmbench ran ten times but time measurements were taken from
>oprofile (on Pentium 4, GLOBAL_POWER_EVENTS in kernel space only, 
>counter overflow: 3.000).
>Results: 33% of the lmbench procs faster on icc, 66% faster on gcc.

Really???

If it is ture using icc 66% faster than gcc., It is wonderful. 
Could you show us detail data to  lmbench results.

Thanks!!

Norihiko



