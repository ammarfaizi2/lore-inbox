Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263233AbTECCQc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 22:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263234AbTECCQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 22:16:32 -0400
Received: from 60.54.252.64.snet.net ([64.252.54.60]:8618 "EHLO
	jaymale.blue-labs.org") by vger.kernel.org with ESMTP
	id S263233AbTECCQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 22:16:31 -0400
Message-ID: <3EB32969.8010902@blue-labs.org>
Date: Fri, 02 May 2003 22:28:57 -0400
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030429
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [FYI] call trace on boot, BusLogic driver, 2.5.68
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

scsi: ***** BusLogic SCSI Driver Version 2.1.16 of 18 July 2002 *****
scsi: Copyright 1995-1998 by Leonard N. Zubkoff <lnz@dandelion.com>
ERROR: SCSI host `BusLogic' has no error handling
ERROR: This is not a safe way to run your SCSI host
ERROR: The error handling must be added to this driver
Call Trace:
 [<c0282ea3>] scsi_register+0x623/0x630
 [<c014a33b>] check_poison_obj+0x3b/0x1b0
 [<c014c2f9>] kmalloc+0x169/0x1c0
 [<c012664c>] __request_region+0x5c/0x90
 [<c047cacd>] BusLogic_DetectHostAdapter+0x1fd/0x390
 [<c0275dc7>] ide_register_driver+0x227/0x360
 [<c0282ed2>] scsi_register_host+0x22/0xc0
 [<c047d5a9>] init_this_scsi_driver+0x19/0x40
 [<c04647bb>] do_initcalls+0x2b/0xa0
 [<c0134da2>] init_workqueues+0x12/0x30
 [<c0105068>] init+0x28/0x150
 [<c0105040>] init+0x0/0x150
 [<c01073ad>] kernel_thread_helper+0x5/0x18


