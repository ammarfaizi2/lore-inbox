Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317547AbSGTWQr>; Sat, 20 Jul 2002 18:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317551AbSGTWQr>; Sat, 20 Jul 2002 18:16:47 -0400
Received: from ns2.bizsystems.net ([63.77.172.2]:8201 "EHLO
	ns2.is.bizsystems.com") by vger.kernel.org with ESMTP
	id <S317547AbSGTWQr>; Sat, 20 Jul 2002 18:16:47 -0400
Message-Id: <200207202219.g6KMJvpK026242@ns2.is.bizsystems.com>
From: "Michael" <michael@insulin-pumpers.org>
To: linux-kernel@vger.kernel.org
Date: Sat, 20 Jul 2002 15:19:57 -0800
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: build error when SMP = No
Reply-to: michael@insulin-pumpers.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i86 based build of 
2.4.19-rc2

When 
Symmetric multi-processing support (CONFIG_SMP) [Y/n/?] n

is Yes, everything builds fine.
if No, the following fatal error occurs

/usr/src/linux-2.4.19-rc2.2/include/linux/kernel_stat.h:45:
`smp_num_cpus' undeclared (first use in this function)
/usr/src/linux-2.4.19-rc2.2/include/linux/kernel_stat.h:45: (Each
undeclared identifier is reported only once
/usr/src/linux-2.4.19-rc2.2/include/linux/kernel_stat.h:45: for each
function it appears in.) make[2]: *** [ksyms.o] 
Error 1 make[2]: Leaving directory 
`/usr/src/linux-2.4.19-rc2.2/kernel' make[1]: *** [first_rule] 

Any joy out there??
Michael
Michael@Insulin-Pumpers.org
