Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265254AbTLaUBo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 15:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265255AbTLaUBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 15:01:44 -0500
Received: from ip3e83a512.speed.planet.nl ([62.131.165.18]:28200 "EHLO
	made0120.speed.planet.nl") by vger.kernel.org with ESMTP
	id S265254AbTLaUBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 15:01:43 -0500
Message-ID: <3FF32B26.1030006@planet.nl>
Date: Wed, 31 Dec 2003 21:01:42 +0100
From: Stef van der Made <svdmade@planet.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20031227
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ide-scsi for DI-30 and strange messages in dmesg
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On a stock 2.6.0-mm2 kernel I see these 'dumps' into dmesg. I'm using a 
onstream Di-30 on a Ak32E with a via chipset. Is this normal as I've 
never seen this symptom before ?

Thanks for your feedback,

Stef

Debug: sleeping function called from invalid context at kernel/sched.c:1814
in_atomic():0, irqs_disabled():1
Call Trace:
 [<c011bc6b>] __might_sleep+0xab/0xd0
 [<c011aa0f>] wait_for_completion+0x1f/0x100
 [<c02343e1>] idetape_wait_for_request+0x71/0x90
 [<c0235509>] idetape_wait_first_stage+0x69/0x70
 [<c0235dd9>] idetape_get_logical_blk+0x139/0x260
 [<c0238378>] idetape_chrdev_ioctl+0x268/0x380
 [<c0165384>] sys_ioctl+0xf4/0x2b0
 [<c032abbf>] syscall_call+0x7/0xb
 
atkbd.c: Unknown key released (translated set 2, code 0x7a on 
isa0060/serio0).
atkbd.c: Unknown key released (translated set 2, code 0x7a on 
isa0060/serio0).
request_module: failed /sbin/modprobe -- net-pf-10. error = 65280
request_module: failed /sbin/modprobe -- net-pf-10. error = 65280
request_module: failed /sbin/modprobe -- sound-slot-1. error = 65280
Debug: sleeping function called from invalid context at kernel/sched.c:1814
in_atomic():0, irqs_disabled():1
Call Trace:
 [<c011bc6b>] __might_sleep+0xab/0xd0
 [<c011aa0f>] wait_for_completion+0x1f/0x100
 [<c02343e1>] idetape_wait_for_request+0x71/0x90
 [<c0235509>] idetape_wait_first_stage+0x69/0x70
 [<c0235dd9>] idetape_get_logical_blk+0x139/0x260
 [<c0238378>] idetape_chrdev_ioctl+0x268/0x380
 [<c0165384>] sys_ioctl+0xf4/0x2b0
 [<c032abbf>] syscall_call+0x7/0xb
 

