Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261511AbTCTPuY>; Thu, 20 Mar 2003 10:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261515AbTCTPuY>; Thu, 20 Mar 2003 10:50:24 -0500
Received: from avscan1.sentex.ca ([199.212.134.11]:26373 "EHLO
	avscan1.sentex.ca") by vger.kernel.org with ESMTP
	id <S261511AbTCTPuS>; Thu, 20 Mar 2003 10:50:18 -0500
Message-ID: <02cc01c2eefa$4f938da0$294b82ce@connecttech.com>
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: <linux-kernel@vger.kernel.org>
Subject: Non-__init functions calling __init functions
Date: Thu, 20 Mar 2003 11:03:56 -0500
Organization: Connect Tech Inc.
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4920.2300
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is always a bug isn't it?

A quick check shows that the following files have non-__init functions
calling __init init_idle() in 2.5.65:

arch/ppc/kernel/smp.c
arch/um/kernel/smp.c
arch/mips/kernel/process.c
arch/mips64/kernel/process.c
arch/parisc/kernel/smp.c
arch/s390x/kernel/smp.c
arch/s390/kernel/smp.c

..Stu


