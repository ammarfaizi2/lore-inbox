Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130450AbRCPKBJ>; Fri, 16 Mar 2001 05:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130448AbRCPKA7>; Fri, 16 Mar 2001 05:00:59 -0500
Received: from usw-sf-sshgate.sourceforge.net ([216.136.171.253]:30967 "EHLO
	usw-sf-netmisc.sourceforge.net") by vger.kernel.org with ESMTP
	id <S130388AbRCPKAr>; Fri, 16 Mar 2001 05:00:47 -0500
To: linux-kernel@vger.kernel.org
Subject: kgdb (kernel source level debugger) for 2.4 kernels
Cc: dave@gcom.com
Message-Id: <E14dr1g-00008p-00@usw-pr-shell1.sourceforge.net>
From: "Amit S. Kale" <akale@users.sourceforge.net>
Date: Fri, 16 Mar 2001 02:00:04 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kgdb, kernel source level debugger for x86 linux is available now.
Please visit http://kgdb.sourceforge.net/ for downloading.

http://kgdb.sourceforge.net/linux-2.4.2-kgdb.patch is the debugger
patch for 2.4.2 linux kernel.

This version of kgdb has much better support for threads and nmi
watchdog.

Correct register contents for all threads can be seen now.
nmi watchdog is also handled correctly without hangs.
Unlike previous version, status of threads running on other cpus
is reported correctly in case of nmi watchdog occurrance.

Thanks to Dave Grothe for helping me in improving nmi watchdog support.

Regards.
Amit S. Kale
(akale@users.sourceforge.net)
Linux kernel source level debugger http://kgdb.sourceforge.net/
