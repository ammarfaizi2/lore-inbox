Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267721AbTAaI0q>; Fri, 31 Jan 2003 03:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267725AbTAaI0q>; Fri, 31 Jan 2003 03:26:46 -0500
Received: from ims21.stu.nus.edu.sg ([137.132.14.228]:26266 "EHLO
	ims21.stu.nus.edu.sg") by vger.kernel.org with ESMTP
	id <S267721AbTAaI0p> convert rfc822-to-8bit; Fri, 31 Jan 2003 03:26:45 -0500
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: PROBLEM: Unexpected EOF when unzipping kernel source 2.4.18
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Date: Fri, 31 Jan 2003 16:36:06 +0800
Message-ID: <720FB032F37C0D45A11085D881B033684CBC40@MBXSRV24.stu.nus.edu.sg>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PROBLEM: Unexpected EOF when unzipping kernel source 2.4.18
thread-index: AcLJA8xQzghI4ZOmRASRpsQaCZ7Jng==
From: "Eng Se-Hsieng" <g0202512@nus.edu.sg>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 31 Jan 2003 08:36:07.0140 (UTC) FILETIME=[CC6A5240:01C2C903]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem: Unexpected EOF in archive of linux
kernel 2.4.18
[2.] Full description of the problem/report: 

linux/arch/sh/mm/cache-sh4.c
gzip: stdin: unexpected end of file
linux/arch/sh/mm/clear_page.S
linux/arch/sh/mm/copy_page.S
tar: Unexpected EOF in archive
tar: Unexpected EOF in archive
tar: Error is not recoverable: exiting now.

[3.] Keywords (i.e., modules, networking, kernel): kernel
[4.] Kernel version (from /proc/version): :Linux version 2.4.18-3
[5.] Output of Oops.. message (if applicable) with symbolic information
resolved (see Documentation/oops-tracing.txt) 
[6.] A small shell script or example program which triggers the problem
(if possible) 

tar zxpvf linux-2.4.18.tar.gz


As such, make xconfig gives me the following errors

Make -C scripts kconfig.tk
Make: *** scripts: No such file or directory. Stop.
Make: *** [xconfig[ Error 2

Please help. Thank you.

Regards,
Se-Hsieng
