Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129664AbQKQSEJ>; Fri, 17 Nov 2000 13:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129171AbQKQSEA>; Fri, 17 Nov 2000 13:04:00 -0500
Received: from mh2dmz1.bloomberg.com ([199.172.169.37]:47818 "EHLO
	mh2dmz1.bloomberg.com") by vger.kernel.org with ESMTP
	id <S129664AbQKQSDr>; Fri, 17 Nov 2000 13:03:47 -0500
From: Dave Seff <dseff@bloomberg.com>
Date: Fri, 17 Nov 2000 13:32:45 -0500
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Cc: groudier@club-internet.fr
Subject: Kernel Panic (more)
MIME-Version: 1.0
Message-Id: <00111713324502.05390@jupiter>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

output from ksymoops for my kernel panic


>>EIP; c024877f <ncr_sir_to_redo+17/2ac>   <=====
Trace; c011056f <smp_local_timer_interrupt+d3/148>
Trace; c0240fe3 <scsi_old_done+4db/5b0>
Trace; c0248c06 <ncr_int_sir+f6/6e4>
Trace; c010bb79 <do_IRQ+3d/58>
Trace; c0247e1e <ncr_exception+172/374>
Trace; c010b9e9 <handle_IRQ_event+61/98>
Trace; c0249ebf <ncr53c8xx_intr+3b/b4>
Trace; c0114c0a <update_wall_time+12/48>
Trace; c011056f <smp_local_timer_interrupt+d3/148>
Trace; c010b9e9 <handle_IRQ_event+61/98>
Trace; c0114e44 <timer_bh+100/404>
Trace; c010a58f <do_8259A_IRQ+8f/d0>
Trace; c011ac71 <do_bottom_half+89/ac>
Trace; c010bb79 <do_IRQ+3d/58>
Trace; c010bb90 <do_IRQ+54/58>
Trace; c0110fbe <do_check_pgt_cache+9e/bc>
Trace; c010a5e8 <common_interrupt+18/20>
Trace; c0107af9 <cpu_idle+41/54>
Trace; c0106000 <get_options+0/7c>
Trace; c01001ae <L6+0/2>
Code;  c024877f <ncr_sir_to_redo+17/2ac>
00000000 <_EIP>:
Code;  c024877f <ncr_sir_to_redo+17/2ac>   <=====
   0:   8a 45 40                  mov    0x40(%ebp),%al   <=====
Code;  c0248782 <ncr_sir_to_redo+1a/2ac>
   3:   8d 14 80                  lea    (%eax,%eax,4),%edx
Code;  c0248785 <ncr_sir_to_redo+1d/2ac>
   6:   8d 14 d0                  lea    (%eax,%edx,8),%edx
Code;  c0248788 <ncr_sir_to_redo+20/2ac>
   9:   8d 54 96 7c               lea    0x7c(%esi,%edx,4),%edx
Code;  c024878c <ncr_sir_to_redo+24/2ac>
   d:   89 54 24 2c               mov    %edx,0x2c(%esp,1)
Code;  c0248790 <ncr_sir_to_redo+28/2ac>
  11:   8b 44 24 00               mov    0x0(%esp,1),%eax

Aiee, killing interrupt handler
Kernel panic: Attempted to kill the idle task!
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
