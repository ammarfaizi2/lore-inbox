Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbTIZWMM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 18:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261676AbTIZWMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 18:12:12 -0400
Received: from [212.95.164.66] ([212.95.164.66]:34564 "HELO ns.unixsol.org")
	by vger.kernel.org with SMTP id S261664AbTIZWMK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 18:12:10 -0400
Message-ID: <3F74B9B7.2010807@unixsol.org>
Date: Sat, 27 Sep 2003 01:12:07 +0300
From: Georgi Chorbadzhiyski <gf@unixsol.org>
Organization: Unix Solutions Ltd. (http://unixsol.org)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030915
X-Accept-Language: en, en-us, bg
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [2.6.0-test5-mm1] Debug: sleeping function called from invalid context
 at include/asm/uaccess.h:512
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get this messages all the time when dosemu is running. I'm using
Linux version 2.6.0-test5-mm1 (root@gf) (gcc version 3.2.3) #2 Tue Sep 9 17:47:25 EEST 2003
on slackware-current. If more information is needed I'll be happy to provide
it.

Sep 26 23:36:47 gf kernel: Debug: sleeping function called from invalid context at include/asm/uaccess.h:512
Sep 26 23:36:47 gf kernel: in_atomic():0, irqs_disabled():1
Sep 26 23:36:47 gf kernel: Call Trace:
Sep 26 23:36:47 gf kernel:  [<c010ce55>] do_general_protection+0x0/0x9e
Sep 26 23:36:47 gf kernel:  [<c011f5da>] __might_sleep+0x9c/0xb6
Sep 26 23:36:47 gf kernel:  [<c010f3f2>] save_v86_state+0x66/0x207
Sep 26 23:36:47 gf kernel:  [<c010ce55>] do_general_protection+0x0/0x9e
Sep 26 23:36:47 gf kernel:  [<c0375442>] work_notifysig_v86+0x6/0x14
Sep 26 23:36:47 gf kernel:  [<c03753ef>] syscall_call+0x7/0xb
Sep 26 23:36:47 gf kernel:
Sep 26 23:36:48 gf kernel: Debug: sleeping function called from invalid context at include/asm/uaccess.h:512
Sep 26 23:36:48 gf kernel: in_atomic():0, irqs_disabled():1
Sep 26 23:36:48 gf kernel: Call Trace:
Sep 26 23:36:48 gf kernel:  [<c011f5da>] __might_sleep+0x9c/0xb6
Sep 26 23:36:48 gf kernel:  [<c010f3f2>] save_v86_state+0x66/0x207
Sep 26 23:36:48 gf kernel:  [<c0375442>] work_notifysig_v86+0x6/0x14
Sep 26 23:36:48 gf kernel:  [<c03753ef>] syscall_call+0x7/0xb
Sep 26 23:36:48 gf kernel:
Sep 26 23:36:49 gf kernel: Debug: sleeping function called from invalid context at include/asm/uaccess.h:512
Sep 26 23:36:49 gf kernel: in_atomic():0, irqs_disabled():1
Sep 26 23:36:49 gf kernel: Call Trace:
Sep 26 23:36:49 gf kernel:  [<c010ce55>] do_general_protection+0x0/0x9e
Sep 26 23:36:49 gf kernel:  [<c011f5da>] __might_sleep+0x9c/0xb6
Sep 26 23:36:49 gf kernel:  [<c010f3f2>] save_v86_state+0x66/0x207
Sep 26 23:36:49 gf kernel:  [<c010ce55>] do_general_protection+0x0/0x9e
Sep 26 23:36:49 gf kernel:  [<c0375442>] work_notifysig_v86+0x6/0x14
Sep 26 23:36:49 gf kernel:  [<c03753ef>] syscall_call+0x7/0xb
Sep 26 23:36:49 gf kernel:
Sep 26 23:36:50 gf kernel: Debug: sleeping function called from invalid context at include/asm/uaccess.h:512
Sep 26 23:36:50 gf kernel: in_atomic():0, irqs_disabled():1
Sep 26 23:36:50 gf kernel: Call Trace:
Sep 26 23:36:50 gf kernel:  [<c010ce55>] do_general_protection+0x0/0x9e
Sep 26 23:36:50 gf kernel:  [<c011f5da>] __might_sleep+0x9c/0xb6
Sep 26 23:36:50 gf kernel:  [<c010f3f2>] save_v86_state+0x66/0x207
Sep 26 23:36:50 gf kernel:  [<c010ce55>] do_general_protection+0x0/0x9e
Sep 26 23:36:50 gf kernel:  [<c0375442>] work_notifysig_v86+0x6/0x14
Sep 26 23:36:50 gf kernel:  [<c03753ef>] syscall_call+0x7/0xb

-- 
Georgi Chorbadzhiyski
http://georgi.unixsol.org/

