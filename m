Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbTFHPXL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 11:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbTFHPXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 11:23:11 -0400
Received: from franka.aracnet.com ([216.99.193.44]:58813 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S261895AbTFHPXK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 11:23:10 -0400
Date: Sun, 08 Jun 2003 08:36:46 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 787] New: Errors with feral driver
Message-ID: <25710000.1055086606@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

           Summary: Errors with feral driver
    Kernel Version: 2.5.70 + feral driver
            Status: NEW
          Severity: normal
             Owner: andmike@us.ibm.com
         Submitter: mbligh@aracnet.com


Distribution: Debian sid
Hardware Environment: NUMA-Q, isp1040 card + qlogic 2300 f/c card

I get lots of these errors on bootup with the feral driver

handlers:
[<c01d22f4>] (isplinux_intr+0x0/0x394)
irq event 19: bogus retval mask 292
Call Trace:
 [<c010af04>] handle_IRQ_event+0x94/0xf0
 [<c010b100>] do_IRQ+0x90/0xfc
 [<c0105000>] _stext+0x0/0x48
 [<c010965e>] common_interrupt+0x42/0x58


