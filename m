Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266213AbUAGNtJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 08:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266209AbUAGNtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 08:49:09 -0500
Received: from [66.98.192.92] ([66.98.192.92]:33689 "EHLO svr44.ehostpros.com")
	by vger.kernel.org with ESMTP id S266213AbUAGNtF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 08:49:05 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Linux Kernel <linux-kernel@vger.kernel.org>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>,
       "x86_64 discussions" <discuss@x86-64.org>
Subject: kgdb 2.0 for kernel 2.6.0
Date: Wed, 7 Jan 2004 19:18:43 +0530
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401071918.43654.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have released kgdb 2.0 for kernel 2.6.0 for i386 and x86_64 architectures at 
http://kgdb.sourceforge.net.

This version of kgdb has been supported by TimeSys Corporation and Storad Inc. 
It contains code from kgdb patches maintained by Andrew Morton (George 
Anzinger), Andi Kleen and Jim Housten.

Significant changes since previous version:
1. This version contains three patches: architecture specific patches for i386 
and x86_64 and a common patch.
2. Automatic loading of modules in gdb is available on x86_64 platform now. 
Debugging of modules, including those in initrd, should be trivial with this 
feature.
3. Hasslefree detach and reconnect from gdb possible on x86_64 platform also.
4. New format of kgdb kernel command line options: kgdbwait, kgdb8250.
5. Shadow thread to get backtraces lost when gdb can't go beyond do_IRQ.
6. Uses new thread list packet qf instead of qL. This fixes the thread 
information loss previous versions of kgdb had.

-- 
Amit Kale
EmSysSoft (http://www.emsyssoft.com)
KGDB: Linux Kernel Source Level Debugger (http://kgdb.sourceforge.net)

