Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318497AbSHEO2A>; Mon, 5 Aug 2002 10:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318501AbSHEO2A>; Mon, 5 Aug 2002 10:28:00 -0400
Received: from csmail.cs.ccu.edu.tw ([140.123.101.2]:29200 "EHLO
	csmail.cs.ccu.edu.tw") by vger.kernel.org with ESMTP
	id <S318497AbSHEO17>; Mon, 5 Aug 2002 10:27:59 -0400
Message-ID: <021b01c23c8d$22becc60$74667b8c@edward>
From: "=?big5?B?RWR3YXJkIFNoYW8gXCiq8qp2sOpcKQ==?=" <szg90@cs.ccu.edu.tw>
To: <linux-kernel@vger.kernel.org>
Subject: a question about __down() in Linux/arch/i386/kernel/semaphore.c
Date: Mon, 5 Aug 2002 22:33:58 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a question about __down() in kernel 2.4.18
(Linux/arch/i386/kernel/semaphore.c)
I found the last line of __down() is
wake_up(&sem->wait);
but in kernel 2.5.28, i didn't see this line..
is this line necessary in kernel 2.4.18?
why?

Thank you very much.

Best Regard!!!

-Edward Shao-


