Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263588AbTHXCHN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 22:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263494AbTHXCHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 22:07:13 -0400
Received: from law14-f69.law14.hotmail.com ([64.4.21.69]:59655 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S263627AbTHXCHK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 22:07:10 -0400
X-Originating-IP: [194.85.81.178]
X-Originating-Email: [john_r_newbie@hotmail.com]
From: "John Newbie" <john_r_newbie@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: rmmod ide-scsi bug?
Date: Sun, 24 Aug 2003 06:07:09 +0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <LAW14-F69RVFvfr3qTN00005076@hotmail.com>
X-OriginalArrivalTime: 24 Aug 2003 02:07:10.0263 (UTC) FILETIME=[6D3C3C70:01C369E4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've get this message on 2.6-test4.

PM: Removing info for No Bus:ide-scsi
Device 'ide-scsi' does not have a release() function, it is broken and must 
be fixed.
Badness in device_release at drivers/base/core.c:85
Call Trace:
[<c026acfa>] kobject_cleanup+0x4a/0x50
[<d10a4bef>] exit_idescsi_module+0xf/0x2b [ide_scsi]
[<c0137276>] sys_delete_module+0x136/0x190
[<c014b800>] do_munmap+0x120/0x190
[<c010b35b>] syscall_call+0x7/0xb

but module unloaded, and inserted back ok.

_________________________________________________________________
Help STOP SPAM with the new MSN 8 and get 2 months FREE*  
http://join.msn.com/?page=features/junkmail

