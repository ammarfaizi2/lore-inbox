Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263949AbTCWWDx>; Sun, 23 Mar 2003 17:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263951AbTCWWDx>; Sun, 23 Mar 2003 17:03:53 -0500
Received: from franka.aracnet.com ([216.99.193.44]:56210 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S263949AbTCWWDt>; Sun, 23 Mar 2003 17:03:49 -0500
Date: Sun, 23 Mar 2003 14:14:54 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 492] New: Zip drive parallel-port driver causes segfault in 2.5.x
Message-ID: <2070000.1048457694@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=492

           Summary: Zip drive parallel-port driver causes segfault in 2.5.x
    Kernel Version: 2.5.x
            Status: NEW
          Severity: high
             Owner: andmike@us.ibm.com
         Submitter: wa1ter@myrealbox.com


Distribution:gentoo linux 1.4
Hardware Environment:soyo k7via/single Athlon mb
Software Environment:gcc3.2.2/module-init-tools 0.9.10-r4
Problem Description: ppa module doesn't work properly and, if compiled into
kernel it causes a kernel panic at boot.
Steps to reproduce:compile ppa.ko as a module and modprobe ppa:

Error messages include 'scheduling while atomic' and 'oops: 0004 [#2]'
and 'unable to handle kernel paging request' and 'modprobe exited with
preempt_count 1'.

This same problem has existed at least since kernel 2.5.49 when I
started trying the 2.5 series, and I suspect that ppa has never
worked with 2.5 kernels, but I don't know for sure.  The driver
works fine with 2.4 kernels.

Note:  it is NOT necessary to have a parallel Zip drive to test this
kernel module.  The ppa module should load without error even with no
Zip drive connected!


