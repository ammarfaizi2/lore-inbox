Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbUDZLYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbUDZLYq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 07:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263171AbUDZLYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 07:24:46 -0400
Received: from host16.apollohosting.com ([209.239.37.142]:7558 "EHLO
	host16.apollohosting.com") by vger.kernel.org with ESMTP
	id S261236AbUDZLYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 07:24:45 -0400
To: "Linux Kernel ML" <linux-kernel@vger.kernel.org>
Subject: Initio INI-9X00U/UW error handling in 2.6
Date: Mon, 26 Apr 2004 13:24:34 +0200
From: "Mirko Caserta" <mirko@mcaserta.com>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opr619y8b4psnffn@mail.mcaserta.com>
User-Agent: Opera M2/7.50 (Linux, build 663)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I was just wondering if someone is working on a fix for this:

i91u: PCI Base=0xD000, IRQ=11, BIOS=0xFF000, SCSI ID=7
i91u: Reset SCSI Bus ...
ERROR: SCSI host `INI9100U' has no error handling
ERROR: This is not a safe way to run your SCSI host
ERROR: The error handling must be added to this driver
[<c02f7728>] scsi_host_alloc+0x2d8/0x2e0
[<c02f774f>] scsi_register+0x1f/0x70
[<c02ffe0f>] i91u_detect+0x1bf/0x2d0
[<c0300440>] i91u_release+0x0/0x46
[<c04e43fe>] init_this_scsi_driver+0x3e/0x100
[<c04c892c>] do_initcalls+0x2c/0xc0
[<c012e1c5>] init_workqueues+0x15/0x2c
[<c01004ba>] init+0x5a/0x190
[<c0100460>] init+0x0/0x190
[<c0104035>] kernel_thread_helper+0x5/0x10
scsi0 : Initio INI-9X00U/UW SCSI device driver; Revision: 1.03g
scsi: Device offlined - not ready after error recovery: host 0 channel 0  
id 0 lun 0
scsi: Device offlined - not ready after error recovery: host 0 channel 0  
id 2 lun 0
scsi: Device offlined - not ready after error recovery: host 0 channel 0  
id 4 lun 0
