Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266199AbSKOLyP>; Fri, 15 Nov 2002 06:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266203AbSKOLyO>; Fri, 15 Nov 2002 06:54:14 -0500
Received: from [192.109.29.2] ([192.109.29.2]:14341 "EHLO
	fdgex1.intern.fujitsu.de") by vger.kernel.org with ESMTP
	id <S266199AbSKOLyO>; Fri, 15 Nov 2002 06:54:14 -0500
Message-ID: <F8108EB579C2D611BB97005004E8A89325BA8B@fdgex1.intern.fujitsu.de>
From: "Kammerloher, Josef" <Josef.Kammerloher@est.fujitsu.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Every semaphore call results in "uninterruptable sleep"
Date: Fri, 15 Nov 2002 13:01:21 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I use SuSE 8.1 ( kernel 2.4.19-4GB) and a program with semaphores.
It runs okay on many PCs and laptops except one laptop (with Pentium
Mobile).

Every semaphore function (semget(),..) ,  "ipcs -s" ... results in
"uninterruptable sleep".
The processes cannot be killed by kill -9.

cat /proc/sys/kernel/sem returns   250  256000  32 1024 

I always use the default kernel without special configurations.

What can I do ??
Thanks for your help,
Josef

