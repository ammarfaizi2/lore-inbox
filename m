Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266557AbRGTEbr>; Fri, 20 Jul 2001 00:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266567AbRGTEbg>; Fri, 20 Jul 2001 00:31:36 -0400
Received: from smtp2.ihug.co.nz ([203.109.252.8]:18438 "EHLO smtp2.ihug.co.nz")
	by vger.kernel.org with ESMTP id <S266557AbRGTEbb>;
	Fri, 20 Jul 2001 00:31:31 -0400
Content-Type: text/plain; charset=US-ASCII
From: Matthew Gardiner <kiwiunix@ihug.co.nz>
To: linux-kernel@vger.kernel.org
Subject: Warning: indirect lcall without `*'
Date: Fri, 20 Jul 2001 16:29:58 +1200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01072016295800.27056@kiwiunix.ihug.co.nz>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

gcc -D__KERNEL__ -I/usr/src/linux-2.4.6/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE   -c -o apm.o apm.c
{standard input}: Assembler messages:
{standard input}:188: Warning: indirect lcall without `*'
{standard input}:265: Warning: indirect lcall without `*'
make[1]: Leaving directory `/usr/src/linux-2.4.6/arch/i386/kernel'
make -C  arch/i386/mm CFLAGS="-D__KERNEL__ -I/usr/src/linux-2.4.6/include 
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=i686 -DMODULE" MAKING_MODULES=1 modules
make[1]: Entering directory `/usr/src/linux-2.4.6/arch/i386/mm'
make[1]: Nothing to be done for `modules'.
make[1]: Leaving directory `/usr/src/linux-2.4.6/arch/i386/mm'
make -C  arch/i386/lib CFLAGS="-D__KERNEL__ -I/usr/src/linux-2.4.6/include 
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=i686 -DMODULE" MAKING_MODULES=1 modules
make[1]: Entering directory `/usr/src/linux-2.4.6/arch/i386/lib'
make[1]: Nothing to be done for `modules'.
make[1]: Leaving directory `/usr/src/linux-2.4.6/arch/i386/lib'
[root@kiwiunix linux]#
-- 
WARNING:

This email was written on an OS using the viral 'GPL' as its license.

Please check with Bill Gates before continuing to read this email/posting.
