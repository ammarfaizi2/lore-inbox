Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264602AbTLKJK6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 04:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264604AbTLKJK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 04:10:58 -0500
Received: from mail05.inetu.net ([209.235.192.122]:6924 "EHLO mail05.inetu.net")
	by vger.kernel.org with ESMTP id S264602AbTLKJK4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 04:10:56 -0500
Message-ID: <01f101c3bfc8$246948f0$00f7fea9@unisoft.net>
From: "san" <sanjeev@unisoftindia.net>
To: <linux-kernel@vger.kernel.org>
Subject: nmi_watchdog_disable
Date: Thu, 11 Dec 2003 14:51:03 +0530
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi mates

Greetings to everybody

I am a newbie to compile this linux kernel compilation.

I am trying to compile the kernel which supported ARM processor
(SA1110-Assabet)

While compiling i am getting the error as followed.

CC      init/version.o
LD      init/built-in.o
LD      .tmp_vmlinux1
arch/arm/mach-sa1100/built-in.o(.text+0xdf8): In function
sa11x0_pm_prepare':
undefined reference to `nmi_watchdog_disable'
arch/arm/mach-sa1100/built-in.o(.text+0xe10): In function
sa11x0_pm_finish':
undefined reference to `nmi_watchdog_enable'
make: *** [.tmp_vmlinux1] Error 1


1. when i was grepping the nmi_watchdog i found this in nmi.c files located
at arch/i386/kernel
  arch/ppc/kernel folders , but it is not available at arm folder.

2. Why do i need power managment, even if i am disabling it in .config using
make menuconfig.

any patches or nmi.c for arm processor.?


regds
san



