Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313571AbSHWXDA>; Fri, 23 Aug 2002 19:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313628AbSHWXDA>; Fri, 23 Aug 2002 19:03:00 -0400
Received: from 24-148-63-229.na.21stcentury.net ([24.148.63.229]:50795 "HELO
	wotke.danapple.com") by vger.kernel.org with SMTP
	id <S313571AbSHWXC7>; Fri, 23 Aug 2002 19:02:59 -0400
To: linux-kernel@vger.kernel.org
Cc: kernel@danapple.com
Subject: 2.5.31 build failure
From: "Daniel I. Applebaum" <kernel@danapple.com>
Date: Fri, 23 Aug 2002 18:07:01 -0500
Message-Id: <20020823230706.61F8F10B54@wotke.danapple.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I get the following error when trying to build 2.5.31:
gcc -Wp,-MD,./.entry.o.d -D__ASSEMBLY__ -D__KERNEL__ -I/usr/src/linux-2.5.31/include -nostdinc -iwithprefix include  -traditional  -c -o entry.o entry.S
/usr/lib/gcc-lib/i386-redhat-linux/2.96/tradcpp0: Usage: /usr/lib/gcc-lib/i386-redhat-linux/2.96/tradcpp0 [switches] input output
make[2]: *** [entry.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.31/arch/i386/kernel'
make[1]: *** [arch/i386/kernel] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.31'
make: *** [bzImage] Error 2

Dan.
