Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261708AbTDBTwi>; Wed, 2 Apr 2003 14:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261768AbTDBTwg>; Wed, 2 Apr 2003 14:52:36 -0500
Received: from ccnetbkup.hku.hk ([147.8.2.96]:4047 "EHLO mail2.hku.hk")
	by vger.kernel.org with ESMTP id <S261708AbTDBTwd>;
	Wed, 2 Apr 2003 14:52:33 -0500
Message-ID: <003b01c2f952$f2cb27f0$1d1a630a@tefs.com>
From: "George Chang" <h9916628@hkusua.hku.hk>
To: <linux-kernel@vger.kernel.org>
Subject: System Hang when sys_open & then interruptible_sleep_on()
Date: Thu, 3 Apr 2003 04:03:37 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-MailScanner: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am modifying a protocol stack. the stack will then be inserted as a
module. I found the system will hang when the program run
interruptible_sleep_on() after the use of sys_open and other file
operations' system call.

Could you help? Thanks

George

Part 3 Student
HKU EEE


