Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263887AbSIQIQK>; Tue, 17 Sep 2002 04:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263888AbSIQIQK>; Tue, 17 Sep 2002 04:16:10 -0400
Received: from [195.218.232.222] ([195.218.232.222]:30980 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S263887AbSIQIQK>; Tue, 17 Sep 2002 04:16:10 -0400
Date: Tue, 17 Sep 2002 13:29:23 +0500 (SAMST)
From: Vlad Harchev <hvv@hippo.ru>
To: linux-kernel@vger.kernel.org
Subject: support for offset > 2GB on x86 in losetup needed
Message-ID: <Pine.LNX.4.10.10209171323250.1364-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hello, 

 Currently linux-2.4 on x86  doesn't allow to use offsets greater than 2GB
for losetup utility. Looking at the code, it turns out that the kernel is
guilty - linux kernel doesn't allow offsets greater than 2Gb since it uses
32-bit wide signed (why signed?) integer for storing the offset on x86..

 That's a very severe limitation IMHO, it would be very nice to fix this in
2.5 at least (but it would be better to fix it in 2.4 of course :).

 What do you think about this?

PS: I'm not on the list, so please cc replies to me.

 Best regards,
  -Vlad


