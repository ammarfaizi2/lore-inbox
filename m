Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315115AbSEDRtj>; Sat, 4 May 2002 13:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315137AbSEDRti>; Sat, 4 May 2002 13:49:38 -0400
Received: from vivi.uptime.at ([62.116.87.11]:7373 "EHLO vivi.uptime.at")
	by vger.kernel.org with ESMTP id <S315115AbSEDRti>;
	Sat, 4 May 2002 13:49:38 -0400
From: "Oliver Pitzeier" <o.pitzeier@uptime.at>
To: "'Linux Kernel'" <linux-kernel@vger.kernel.org>
Subject: Another problem with Alpha and 2.5.13
Date: Sat, 4 May 2002 19:46:55 +0200
Organization: =?us-ascii?Q?UPtime_Systemlosungen?=
Message-ID: <000f01c1f393$ae6e2280$1201a8c0@pitzeier.priv.at>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi volks!

Here the problem
raid5.c: In function `raid5_diskop':
raid5.c:1725: dereferencing pointer to incomplete type
raid5.c:1737: dereferencing pointer to incomplete type
raid5.c:1738: dereferencing pointer to incomplete type
raid5.c:1749: dereferencing pointer to incomplete type
raid5.c:1763: dereferencing pointer to incomplete type
raid5.c:1764: dereferencing pointer to incomplete type
raid5.c:1780: dereferencing pointer to incomplete type
raid5.c:1799: dereferencing pointer to incomplete type
raid5.c:1800: dereferencing pointer to incomplete type
raid5.c:1819: dereferencing pointer to incomplete type
raid5.c:1824: dereferencing pointer to incomplete type
raid5.c:1827: dereferencing pointer to incomplete type
raid5.c:1833: dereferencing pointer to incomplete type
raid5.c:1839: dereferencing pointer to incomplete type
raid5.c:1840: dereferencing pointer to incomplete type
raid5.c:1850: dereferencing pointer to incomplete type
raid5.c:1855: dereferencing pointer to incomplete type
raid5.c:1856: dereferencing pointer to incomplete type
raid5.c:1936: dereferencing pointer to incomplete type
raid5.c:1937: dereferencing pointer to incomplete type
raid5.c:1938: dereferencing pointer to incomplete type
raid5.c:1943: dereferencing pointer to incomplete type
raid5.c:1945: dereferencing pointer to incomplete type
raid5.c:1956: dereferencing pointer to incomplete type
raid5.c:1983: dereferencing pointer to incomplete type
raid5.c:1717: warning: `i' might be used uninitialized in this function
raid5.c:1719: warning: `tmp' might be used uninitialized in this
function
raid5.c:1719: warning: `sdisk' might be used uninitialized in this
function
raid5.c:1719: warning: `adisk' might be used uninitialized in this
function
raid5.c: At top level:
raid5.c:1991: warning: initialization from incompatible pointer type
raid5.c:2000: warning: initialization from incompatible pointer type
raid5.c:2002: parse error before `raid5_init'
raid5.c:2003: warning: return type defaults to `int'
make[2]: *** [raid5.o] Error 1
make[2]: Leaving directory `/root/linux-2.5.13/drivers/md'
make[1]: *** [_modsubdir_md] Error 2
make[1]: Leaving directory `/root/linux-2.5.13/drivers'
make: *** [_mod_drivers] Error 2

????


