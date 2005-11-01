Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750940AbVKAQoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbVKAQoA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 11:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbVKAQoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 11:44:00 -0500
Received: from ns.dynamicweb.hu ([195.228.155.139]:58850 "EHLO dynamicweb.hu")
	by vger.kernel.org with ESMTP id S1750939AbVKAQn7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 11:43:59 -0500
Message-ID: <021a01c5df04$43d457e0$0400a8c0@dcccs>
From: "JaniD++" <djani22@dynamicweb.hu>
To: <linux-kernel@vger.kernel.org>
Subject: *** glibc detected *** nmap: malloc(): memory corruption: 0x08718a50 ***
Date: Tue, 1 Nov 2005 17:49:43 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list,

I get this, on my dual-xeon ECC-reg memory system.
What is this? :-)

kernel: 2.6.13
(everything looks like normal)

Thanks,

Janos

[root@dy-xeon-1 r]# nmap -O 80.99.___.__

Starting nmap V. 3.00 ( www.insecure.org/nmap/ )
*** glibc detected *** nmap: malloc(): memory corruption: 0x08718a50 ***
======= Backtrace: =========
/lib/libc.so.6[0xb7e793ea]
/lib/libc.so.6(calloc+0x91)[0xb7e7a4d9]
nmap[0x8055cf0]
nmap[0x805a6c3]
nmap[0x805b6e8]
nmap(vfprintf+0x3195)[0x804ca49]
nmap(__strtoul_internal+0x3a6)[0x8049f4a]
/lib/libc.so.6(__libc_start_main+0xc6)[0xb7e29de6]
nmap(wait+0x5d)[0x8049cc1]
======= Memory map: ========
08048000-08086000 r-xp 00000000 00:0e 20707825   /usr/bin/nmap
08086000-08088000 rwxp 0003d000 00:0e 20707825   /usr/bin/nmap
08088000-08759000 rwxp 08088000 00:00 0          [heap]
b7c00000-b7c21000 rwxp b7c00000 00:00 0
b7c21000-b7d00000 ---p b7c21000 00:00 0
b7d9e000-b7da7000 r-xp 00000000 00:0e 4107664
/lib/libgcc_s-4.0.0-20050520.so.1
b7da7000-b7da8000 rwxp 00009000 00:0e 4107664
/lib/libgcc_s-4.0.0-20050520.so.1
b7da8000-b7de9000 rwxp b7da8000 00:00 0
b7de9000-b7df8000 r-xp 00000000 00:0e 4107341    /lib/libresolv-2.3.5.so
b7df8000-b7df9000 r-xp 0000e000 00:0e 4107341    /lib/libresolv-2.3.5.so
b7df9000-b7dfa000 rwxp 0000f000 00:0e 4107341    /lib/libresolv-2.3.5.so
b7dfa000-b7dfc000 rwxp b7dfa000 00:00 0
b7dfc000-b7e00000 r-xp 00000000 00:0e 4107328    /lib/libnss_dns-2.3.5.so
b7e00000-b7e01000 r-xp 00003000 00:0e 4107328    /lib/libnss_dns-2.3.5.so
b7e01000-b7e02000 rwxp 00004000 00:0e 4107328    /lib/libnss_dns-2.3.5.so
b7e09000-b7e12000 r-xp 00000000 00:0e 4107329    /lib/libnss_files-2.3.5.so
b7e12000-b7e13000 r-xp 00008000 00:0e 4107329    /lib/libnss_files-2.3.5.so
b7e13000-b7e14000 rwxp 00009000 00:0e 4107329    /lib/libnss_files-2.3.5.so
b7e14000-b7e15000 rwxp b7e14000 00:00 0
b7e15000-b7f39000 r-xp 00000000 00:0e 4107308    /lib/libc-2.3.5.so
b7f39000-b7f3b000 r-xp 00124000 00:0e 4107308    /lib/libc-2.3.5.so
b7f3b000-b7f3d000 rwxp 00126000 00:0e 4107308    /lib/libc-2.3.5.so
b7f3d000-b7f3f000 rwxp b7f3d000 00:00 0
b7f3f000-b7f61000 r-xp 00000000 00:0e 4107319    /lib/libm-2.3.5.so
b7f61000-b7f62000 r-xp 00021000 00:0e 4107319    /lib/libm-2.3.5.so
b7f62000-b7f63000 rwxp 00022000 00:0e 4107319    /lib/libm-2.3.5.so
b7f69000-b7f6b000 rwxp b7f69000 00:00 0
b7f6b000-b7f85000 r-xp 00000000 00:0e 4105556    /lib/ld-2.3.5.so
b7f85000-b7f86000 r-xp 00019000 00:0e 4105556    /lib/ld-2.3.5.so
b7f86000-b7f87000 rwxp 0001a000 00:0e 4105556    /lib/ld-2.3.5.so
bfe3a000-bfe85000 rwxp bfe3a000 00:00 0          [stack]
ffffe000-fffff000 ---p 00000000 00:00 0          [vdso]
Aborted


