Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271472AbTGQOs0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 10:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271474AbTGQOs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 10:48:26 -0400
Received: from franka.aracnet.com ([216.99.193.44]:33162 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S271472AbTGQOsR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 10:48:17 -0400
Date: Thu, 17 Jul 2003 08:02:55 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 932] New: [OSS] loading cs4232 yields "kobject_register failed" 
Message-ID: <16160000.1058454175@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=932

           Summary: [OSS] loading cs4232 yields "kobject_register failed"
    Kernel Version: 2.6.0-test1
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: jochen@jochen.org


Distribution: Debian/testing
Hardware Environment: IBM Thinkpad 600

Problem Description:
When loading OSS driver cs4232:
pnp: the driver 'cs4232' has been registered
kobject_register failed for cs4232 (-17)
Call Trace:
 [<c01ad4f9>] kobject_register+0x59/0x60
 [<c01eadb4>] bus_add_driver+0x54/0xd0
 [<c01eb291>] driver_register+0x31/0x40
 [<c01bf431>] pnp_register_driver+0x41/0x80
 [<c6a7e65f>] init_cs4232+0x10f/0x11a [cs4232]
 [<c0131746>] sys_init_module+0x126/0x270
 [<c010936b>] syscall_call+0x7/0xb

<Crystal audio controller (CS4238)> at 0x530 irq 9 dma 1,0


