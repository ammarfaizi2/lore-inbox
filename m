Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283815AbRK3VvR>; Fri, 30 Nov 2001 16:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283826AbRK3VvH>; Fri, 30 Nov 2001 16:51:07 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:47857 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP
	id <S283815AbRK3Vuz>; Fri, 30 Nov 2001 16:50:55 -0500
Date: Fri, 30 Nov 2001 13:51:47 -0800
From: Alan and Vivian Vaughn <avvaughn@pacbell.net>
Subject: devfsd 1.3.20 compile error
To: linux-kernel@vger.kernel.org
Message-id: <5.1.0.14.0.20011130134640.009e30f0@postoffice.pacbell.net>
MIME-version: 1.0
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following error when I tried to compile devfsd 1.3.20.

cc -O2 -I. -Wall   -DLIBNSL="\"/lib/libnsl.so.1\""   -c -o devfsd.o devfsd.c
devfsd.c:480: `DEVFSD_NOTIFY_DELETE' undeclared here (not in a function)
devfsd.c:480: initializer element is not constant
devfsd.c:480: (near initialization for `event_types[7].type')
make: *** [devfsd.o] Error 1

I am using gcc 2.95.3.

