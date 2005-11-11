Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbVKKUpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbVKKUpj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 15:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbVKKUpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 15:45:39 -0500
Received: from [69.222.0.20] ([69.222.0.20]:12813 "EHLO usfltd.com")
	by vger.kernel.org with ESMTP id S1751181AbVKKUpi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 15:45:38 -0500
Subject: =?ISO-8859-1?Q?2=2E6=2E14-rt10=20compilation=20error=20kernel=2Fsched=2E?=
 =?ISO-8859-1?Q?c=3A=20In=20function=20=91=5F=5Fcond=5Fresched=5Fraw=5Fs?=
 =?ISO-8859-1?Q?pinlock'?=
Date: Fri, 11 Nov 2005 14:46:20 -0600
Message-Id: <200511111446.AA29884834@usfltd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
From: "art" <art@usfltd.com>
Reply-To: <art@usfltd.com>
To: <linux-kernel@vger.kernel.org>
CC: <mingo@elte.hu>
X-Mailer: <IMail v8.05>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  LD      arch/i386/mach-default/built-in.o
  LD      arch/i386/crypto/built-in.o
  AS [M]  arch/i386/crypto/aes-i586-asm.o
  CC [M]  arch/i386/crypto/aes.o
  LD [M]  arch/i386/crypto/aes-i586.o
  CC      kernel/sched.o
kernel/sched.c: In function ‘__cond_resched_raw_spinlock’:
kernel/sched.c:4593: error: ‘struct <anonymous>’ has no member named ‘break_lock’
kernel/sched.c:4593: error: ‘struct <anonymous>’ has no member named ‘break_lock’
make[1]: *** [kernel/sched.o] Error 1
make: *** [kernel] Error 2

to: linux-kernel@vger.kernel.org
to: mingo@elte.hu

xboom 

