Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264875AbSLQKeL>; Tue, 17 Dec 2002 05:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264883AbSLQKeL>; Tue, 17 Dec 2002 05:34:11 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:51857 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S264875AbSLQKeL>; Tue, 17 Dec 2002 05:34:11 -0500
Message-Id: <4.3.2.7.2.20021217112614.00b55eb0@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Tue, 17 Dec 2002 11:42:41 +0100
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: 2.4.20 copy_from/to_user
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe talking through the top of my hat , however -
copy_from_user and copy_to_user are used all over the place and the
return tested to see if an EFAULT should be generated.
Looking at include/asm-i386/uaccess.h and arch/i386/lib/usercopy.c
I don't see how these return anything but the 3rd (length) param.

Margit 

