Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264430AbUFEDTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264430AbUFEDTl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 23:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264484AbUFEDTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 23:19:40 -0400
Received: from falcon.mail.pas.earthlink.net ([207.217.120.74]:26350 "EHLO
	falcon.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S264430AbUFEDTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 23:19:37 -0400
Message-ID: <40C13BC1.1060309@earthlink.net>
Date: Fri, 04 Jun 2004 20:19:29 -0700
From: Alberto Nava <betonava@earthlink.net>
Reply-To: beto@kasenna.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02 (VAUSSU03)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: CPU  not responding on Dual Xeon SuperMicro motherboard (2.6)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 
When booting 2.6 kernels on a Super Micro P4DP6 dual
Xeon motherboard sometimes the kernel fails to initialize one of the
HT CPUs.

I tried with 2.6.5, 2.6.6 and 2.6.7-rc2, and they all exhibit the
problem at least 1 every 10 reboots. The 2.4.25 kernel did not exhibit
the problem on a overnight reboot loop.

The motherboard is SuperMicro P4DP6 and processors are
Intel(R) Xeon(TM) CPU 2.40GHz stepping 07

I've tried on several similar machines with the same results.

Any idea of what's causing this?

ktwc2 syslog: syslogd startup succeeded
ktwc2 kernel: klogd 1.4.1, log source = /proc/kmsg started.
ktwc2 kernel: even in supervisor mode... Ok.
ktwc2 kernel: Calibrating delay loop... 4767.74 BogoMIPS
ktwc2 kernel: kdb version 4.3 by Keith Owens, Scott Lurndal. Copyright 
SGI, All Rights Reserved
ktwc2 kernel: Dentry cache hash table entries: 262144 (order: 8, 1048576 
bytes)
ktwc2 kernel: Inode-cache hash table entries: 131072 (order: 7, 524288 
bytes)
ktwc2 kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
ktwc2 kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
ktwc2 kernel: CPU: L2 cache: 512K
ktwc2 kernel: CPU: Physical Processor ID: 0
ktwc2 syslog: klogd startup succeeded
ktwc2 kernel: Intel machine check architecture supported.
ktwc2 kernel: Intel machine check reporting enabled on CPU#0.
ktwc2 kernel: CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
ktwc2 kernel: CPU#0: Thermal monitoring enabled
ktwc2 portmap: portmap startup succeeded
ktwc2 kernel: Enabling fast FPU save and restore... done.
ktwc2 kernel: Enabling unmasked SIMD FPU exception support... done.
ktwc2 kernel: Checking 'hlt' instruction... OK.
ktwc2 kernel: POSIX conformance testing by UNIFIX
ktwc2 kernel: CPU0: Intel(R) Xeon(TM) CPU 2.40GHz stepping 07
ktwc2 kernel: per-CPU timeslice cutoff: 1462.99 usecs.
ktwc2 kernel: task migration cache decay timeout: 2 msecs.
ktwc2 kernel: Getting VERSION: 50014
ktwc2 kernel: Getting VERSION: 50014
ktwc2 kernel: Getting ID: 0
ktwc2 kernel: Getting LVT0: 700
ktwc2 kernel: Getting LVT1: 400
ktwc2 keytable: Loading keymap:
ktwc2 kernel: enabled ExtINT on CPU#0
ktwc2 keytable:
ktwc2 kernel: ESR value before enabling vector: 00000000
ktwc2 keytable: Loading system font:
ktwc2 kernel: ESR value after enabling vector: 00000000
ktwc2 keytable:
ktwc2 kernel: CPU present map: c3
ktwc2 kernel: Booting processor 1/1 eip 3000
ktwc2 kernel: Setting warm reset code and vector.
ktwc2 rc: Starting keytable:  succeeded
ktwc2 kernel: 1.
ktwc2 kernel: 2.
ktwc2 kernel: 3.
ktwc2 kernel: Asserting INIT.
ktwc2 kernel: Waiting for send to finish...
ktwc2 kernel: +Deasserting INIT.
ktwc2 kernel: Waiting for send to finish...
ktwc2 kernel: +#startup loops: 2.
ktwc2 kernel: Sending STARTUP #1.
ktwc2 kernel: After apic_write.
ktwc2 kernel: Startup point 1.
ktwc2 kernel: Waiting for send to finish...
ktwc2 kernel: +Sending STARTUP #2.
ktwc2 random: Initializing random number generator:  succeeded
ktwc2 kernel: After apic_write.
ktwc2 kernel: Startup point 1.
ktwc2 kernel: Waiting for send to finish...
ktwc2 kernel: +After Startup.
ktwc2 kernel: Before Callout 1.
ktwc2 kernel: After Callout 1.
ktwc2 kernel: Not responding.
.......


 


