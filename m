Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267252AbSLRNdU>; Wed, 18 Dec 2002 08:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267253AbSLRNdU>; Wed, 18 Dec 2002 08:33:20 -0500
Received: from [61.140.60.248] ([61.140.60.248]:38959 "HELO 21cn.com")
	by vger.kernel.org with SMTP id <S267252AbSLRNdR>;
	Wed, 18 Dec 2002 08:33:17 -0500
Message-ID: <005001c2a69a$ff6ad100$0604fea9@italy>
From: "pradlu" <pradlu@21cn.com>
To: <linux-kernel@vger.kernel.org>
Subject: why my computer can't  automatically power off after shutdown
Date: Wed, 18 Dec 2002 21:40:12 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have updated my kernel from 2.4.18 to 2.4.20, now my redhat can't
automatically poweroff after shutdown, what I should do?

This is part of my kernal config file,could u tell me where is wrong?

CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
CONFIG_APM_CPU_IDLE=y
# CONFIG_APM_DISPLAY_BLANK is not set
CONFIG_APM_RTC_IS_GMT=y
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

when my system is running, I can see the daemon apm

root 495 1 0 17:04 ? 00:00:00 /usr/sbin/apmd -p 10 -w 5 -W -P


