Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136818AbRECOjH>; Thu, 3 May 2001 10:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136820AbRECOi5>; Thu, 3 May 2001 10:38:57 -0400
Received: from c4.h061013036.is.net.tw ([61.13.36.4]:7699 "EHLO
	exchsmtp.via.com.tw") by vger.kernel.org with ESMTP
	id <S136818AbRECOin>; Thu, 3 May 2001 10:38:43 -0400
Message-ID: <611C3E2A972ED41196EF0050DA92E0760265D594@EXCHANGE2>
From: Yiping Chen <YipingChen@via.com.tw>
To: "'linux_news'" <linux-kernel@vger.kernel.org>
Subject: Compile module error in SUSE Linux
Date: Thu, 3 May 2001 22:38:46 +0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="big5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all:
I am writing linux driver now, when I install driver modules in other Linux
Distributions(Like RedHat, OpenLinux..) ,
 the installation will be successful.
But when I install driver in SUSE Linux, it always appear the following
message:
driver.o: kernel-module version mismatch
	driver.o was compiled for kernel version 2.2.16
	while this kernel is version 2.2.16-SMP.

If I modify the definition of  UTS_RELEASE (from "#define UTS_RELEASE
"2.2.16"" to "#define UTS_RELEASE "2.2.16-SMP"")
in /usr/src/linux/include/linux/version.h file .
And recompile the kernel module, then the installation is successful.
But why? What should I do now? Please help me!!
Thanks!!


-Yiping Chen

