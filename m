Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282508AbRLBACw>; Sat, 1 Dec 2001 19:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282509AbRLBACm>; Sat, 1 Dec 2001 19:02:42 -0500
Received: from m1000.netcologne.de ([194.8.194.104]:59454 "EHLO
	m1000.netcologne.de") by vger.kernel.org with ESMTP
	id <S282508AbRLBACf>; Sat, 1 Dec 2001 19:02:35 -0500
Message-ID: <010501c17ac4$986acf80$25aefea9@ecce>
From: "[MOc]cda*mirabilos" <mirabilos@netcologne.de>
To: "lkml" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.40.0112011350120.1696-100000@blue1.dev.mcafeelabs.com>
Subject: Re: [PATCH] task_struct colouring ...
Date: Sun, 2 Dec 2001 00:02:12 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> movl %esp, %eax
> andl $-8192, %eax
> movl (%eax), %eax

Although I'm good in assembly but bad in gas,
do you consider the middle line good style?

Binary AND with a negative decimal number?


