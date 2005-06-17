Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262039AbVFQSC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262039AbVFQSC6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 14:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262037AbVFQSC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 14:02:57 -0400
Received: from ns1.g-housing.de ([62.75.136.201]:26822 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S262041AbVFQSCp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 14:02:45 -0400
Message-ID: <42B31042.9050104@g-house.de>
Date: Fri, 17 Jun 2005 20:02:42 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Kernel BUG at "include/linux/blkdev.h":607
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

upon booting a yesterday's 2.6.12-rc6 (git) i got a panic:

----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at "include/linux/blkdev.h":607
invalid operand: 0000 [1]
PREEMPT

CPU 0

Modules linked in:

Pid: 1, comm: swapper Not tainted 2.6.12-rc6
RIP: 0010:[<ffffffff80336a48>]
unparseable log message: "<ffffffff80336a48>{scsi_request_fn+536}"

RSP: 0000:ffff810002141808  EFLAGS: 00010046
 RAX: 0000000000000000 RBX: ffff81003faf2360 RCX: ffff81003fae5c02
 RDX: ffff81003faf2360 RSI: 0000000000002b43 RDI: 0000000000000001
 RBP: ffff81003fad7c00 R08: 0000000000000000 R09: ffff81003fac2bc0
 R10: 00000000ffffffff R11: 0000000000000000 R12: ffff81003fad2000
 R13: ffff81003facb818 R14: ffff81003fad7c48 R15: ffff81003fad7de8
 FS:  0000000000000000(0000) GS:ffffffff80543380(0000) knlGS:0000000000000000
 CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
 CR2: 0000000000000000 CR3: 0000000000101000 CR4: 00000000000006e0
 Process swapper (pid: 1, threadinfo ffff810002140000, task ffff81003ffbf440)
 Stack:

(full log here: http://nerdbynature.de/bits/prinz64/2.6.12-rc6/dmesg )

the oops was saved via netconsole and looks pretty messy, i doubt it is
worth anything at all, just wanted to let you know.
2.6.12-rc6-mm1 boots fine.

thank you,
Christian.
-- 
BOFH excuse #42:

spaghetti cable cause packet failure
