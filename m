Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280952AbRKGUfk>; Wed, 7 Nov 2001 15:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280959AbRKGUfc>; Wed, 7 Nov 2001 15:35:32 -0500
Received: from mail.sirinet.net ([198.203.196.92]:7684 "EHLO mail.sirinet.net")
	by vger.kernel.org with ESMTP id <S280952AbRKGUfR>;
	Wed, 7 Nov 2001 15:35:17 -0500
Date: Wed, 7 Nov 2001 14:35:12 -0600 (CST)
From: John Johnson <jjohn@mail.sirinet.net>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: compiling loop device
Message-ID: <Pine.LNX.4.33.0111071432220.29536-100000@mail.sirinet.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


all efforts to build 2.4.14 fail because of loop device

Slackware 8.0
gcc version 2.95.3 20010315

eg. ...

        /usr/src/linux-2.4.14/arch/i386/lib/lib.a
/usr/src/linux-2.4.14/lib/lib.a /usr/src/linux-2.4.14/arch/i386/lib/lib.a
\
        --end-group \
        -o vmlinux
drivers/block/block.o: In function `lo_send':
drivers/block/block.o(.text+0xa86f): undefined reference to
`deactivate_page'
drivers/block/block.o(.text+0xa8b9): undefined reference to
`deactivate_page'
make: *** [vmlinux] Error 1




---
   John Johnson - System Administrator;  Sirius Systems Group
   jjohn@sirinet.net    KJ5AA
   (580) 355-6436

