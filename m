Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267200AbTBXPvG>; Mon, 24 Feb 2003 10:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267204AbTBXPvG>; Mon, 24 Feb 2003 10:51:06 -0500
Received: from franka.aracnet.com ([216.99.193.44]:58594 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267200AbTBXPvE>; Mon, 24 Feb 2003 10:51:04 -0500
Date: Mon, 24 Feb 2003 08:01:14 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 399] New: some ethernet cards, eg. netgear FA311 does not work
 if acpi is on with 2.5.62 
Message-ID: <8600000.1046102474@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=399

           Summary: some ethernet cards, eg. netgear FA311 does not work if
                    acpi is on with 2.5.62
    Kernel Version: 2.5.62
            Status: NEW
          Severity: blocking
             Owner: andrew.grover@intel.com
         Submitter: snxiao@yahoo.com


Distribution: gentoo linux
Hardware Environment: Athlon xp,  Abit KX311 motherboard
Software Environment: gcc 3.2.1
Problem Description:  netgear FA311 NIC uses natsemi driver. If acpi is on,
the driver can be load,  however, it does not work with DHCP

Steps to reproduce: On a computer with netgear FA311 ethernet card, use
kernel 2.5.62 with  "natsemi" and "acpi" compiled in the kernel. reboot,
the NIC will not work.
However, when if pass the option "acpi=off" to the kernel when reboot, the
NIC will work.  

There are some other kernels which also have this problem, for example
2.5.61.

It seems there are some other ethernet cards  also have trouble with acpi
for development kernel.

