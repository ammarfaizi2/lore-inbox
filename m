Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311349AbSCLVDr>; Tue, 12 Mar 2002 16:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311346AbSCLVCr>; Tue, 12 Mar 2002 16:02:47 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:47288 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S311347AbSCLVCe>; Tue, 12 Mar 2002 16:02:34 -0500
Date: Tue, 12 Mar 2002 22:02:14 +0100 (CET)
From: mcp@linux-systeme.de
X-X-Sender: root@codeman.linux-systeme.org
To: linux-kernel@vger.kernel.org
Subject: make xconfig question
Message-ID: <Pine.LNX.4.43.0203122200420.25997-100000@codeman.linux-systeme.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

what EXACTLY does that means:

root@codeman:/usr/src/linux# make xconfig
rm -f include/asm
( cd include ; ln -sf asm-i386 asm)
make -C scripts kconfig.tk
make[1]: Entering directory `/usr/src/linux-2.4.18-mcp3-WOLK/scripts'
cat header.tk >> ./kconfig.tk
./tkparse < ../arch/i386/config.in >> kconfig.tk
statement not in menu
make[1]: *** [kconfig.tk] Error 1
make[1]: Leaving directory `/usr/src/linux-2.4.18-mcp3-WOLK/scripts'
make: *** [xconfig] Error 2

I cannot figure out what i have modified wrong in the arch/i386/config.in
And i don't understand what "statement not in menu" means EXACTLY.

Thanks.

-
Please CC, i am not subscribed to the lkml.
-

Kind regards,
	Marc


