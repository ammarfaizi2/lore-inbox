Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317114AbSGCSKO>; Wed, 3 Jul 2002 14:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317115AbSGCSKN>; Wed, 3 Jul 2002 14:10:13 -0400
Received: from mailhost.cs.tamu.edu ([128.194.130.106]:24259 "EHLO cs.tamu.edu")
	by vger.kernel.org with ESMTP id <S317114AbSGCSKM>;
	Wed, 3 Jul 2002 14:10:12 -0400
Date: Wed, 3 Jul 2002 13:12:41 -0500 (CDT)
From: Xinwen - Fu <xinwenfu@cs.tamu.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: kernel timers vs network card interrupt
Message-ID: <Pine.SOL.4.10.10207031302500.29084-100000@dogbert>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all,
	I'm curious that if a network card interrupt happens at the same
time as the kernel timer expires, what will happen?

	It's said the kernel timer is guaranteed accurate. But if
interrupts are not masked off, the network interrupt also should get
response when a kernel timer expires. So I don't know who will preempt
who.

	Thanks for information!

Xinwen Fu


