Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270453AbTHGTh5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 15:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270458AbTHGTh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 15:37:57 -0400
Received: from CS.ubishops.ca ([206.167.194.132]:4252 "EHLO cs.ubishops.ca")
	by vger.kernel.org with ESMTP id S270453AbTHGThz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 15:37:55 -0400
Message-ID: <3F32AA2B.20809@cs.ubishops.ca>
Date: Thu, 07 Aug 2003 15:36:11 -0400
From: Patrick McLean <pmclean@cs.ubishops.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030731
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test2-mm5 x86-64 link errors
X-Enigmail-Version: 0.76.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get to play with an opteron for a bit, so I'm going to try 2.6 on it, 
but test2-mm5 seems to compile fine, but when it goes to link it, it 
gives these errors:

   LD      init/built-in.o
   LD      .tmp_vmlinux1
kernel/built-in.o(.text+0x359): In function `try_to_wake_up':
: undefined reference to `sched_clock'
kernel/built-in.o(.text+0x3b9): In function `try_to_wake_up':
: undefined reference to `sched_clock'
kernel/built-in.o(.text+0x1150): In function `load_balance':
: undefined reference to `sched_clock'
kernel/built-in.o(.text+0x1ae3): In function `schedule':
: undefined reference to `sched_clock'
kernel/built-in.o(.text+0x3a22): In function `move_task_away':
: undefined reference to `sched_clock'
kernel/built-in.o(.text+0x56cc): more undefined references to 
`sched_clock' follow
make: *** [.tmp_vmlinux1] Error 1

