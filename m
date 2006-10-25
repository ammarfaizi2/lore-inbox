Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbWJYOqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbWJYOqi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 10:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbWJYOqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 10:46:38 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:35496 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932221AbWJYOqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 10:46:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=kwYfxITmTl6LY6KrQ49PZ3yYvju99Ticte6PNYM51m+B68HRz2/yfMPOtx9BsPENAPhxs9+jcE2pNsp3OuZyF+6BNjm+3mkm6F1+wuPujhC0GblPJu7ufrP4+mB75sUyn0sIOD33AItdHuoDoX/iCrf/8WRaI+M1IJUezcROzoA=
Message-ID: <453F78CF.9050708@gmail.com>
Date: Wed, 25 Oct 2006 11:46:39 -0300
From: =?ISO-8859-1?Q?M=E1rcio_Oliveira?= <oliveiram@gmail.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: free_pages error message.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does anybody know what the following message means?
The server logged this message and rebooted.

kernel: free_pages_ok(): incorrect sub-page count ffffffff, of page 
00000040cadd8000(100000000000000).
kernel: bash[10000]: NaT consumption 17179869216
kernel:
kernel: Pid: 1000, comm:                 bash
kernel: EIP is at pipe_release [kernel] 0x50 (2.4.21-27.0.2.EL)
kernel: psr : 0000101008026018 ifs : 800000000000048c ip  : 
[<e0000000045399d0>]    Not tainted
kernel: unat: 0000000000000000 pfs : 000000000000050c rsc : 0000000000000003
kernel: rnat: 0000000000000000 bsps: 0000000000000000 pr  : 80000000f5a52919
kernel: ldrs: 0000000000000000 ccv : 0000000080000000 fpsr: 0009804c0270033f
kernel: b0  : e00000000451d0b0 b6  : e000000004402f70 b7  : e000000004539d20
kernel: f6  : 1003e0000000000000000 f7  : 1003e0000000000000001
kernel: f8  : 1003e0000000000000001 f9  : 1003e0000000000000001
kernel: r1  : e000000004cb7d00 r2  : 0000000000000000 r3  : 0000000000000001
kernel: r8  : e000000004b205f8 r9  : e000000004539d20 r10 : e00000404c59e790
kernel: r11 : e00000405c5aab88 r12 : e00000406b2f7e60 r13 : e00000406b2f0000
kernel: r14 : e000000004b205a8 r15 : e000000004993758 r16 : e00000406b2f0038
kernel: r17 : 0000000000000028 r18 : e000000004a88380 r19 : e000000004b78ec8
kernel: r20 : 0000000000000000 r21 : 0000000080000000 r22 : e00000016b965c90
kernel: r23 : ffffffffffffffef r24 : 0000000000000000 r25 : e00000016b965d30
kernel: r26 : e00000016b965ca8 r27 : e00000016b965cb0 r28 : 0000000000000000
kernel: r29 : 0000000000000000 r30 : 0000000000000001 r31 : 0000000000000004
kernel:
kernel: Call Trace: [<e000000004415960>] sp=0xe00000406b2f79f0 
bsp=0xe00000406b2f1408 show_stack [kernel] 0x80
kernel: [<e000000004431e50>] sp=0xe00000406b2f7bc0 
bsp=0xe00000406b2f13d8 die [kernel] 0x1b0
kernel: [<e000000004432fd0>] sp=0xe00000406b2f7bc0 
bsp=0xe00000406b2f1398 ia64_fault [kernel] 0x170
kernel: [<e00000000440ea20>] sp=0xe00000406b2f7cc0 
bsp=0xe00000406b2f1398 ia64_leave_kernel [kernel] 0x0
kernel: [<e0000000045399d0>] sp=0xe00000406b2f7e60 
bsp=0xe00000406b2f1338 pipe_release [kernel] 0x50
kernel: [<e00000000451d0b0>] sp=0xe00000406b2f7e60 
bsp=0xe00000406b2f12e8 __fput [kernel] 0x350
kernel: [<e00000000451cd40>] sp=0xe00000406b2f7e60 
bsp=0xe00000406b2f12d0 fput [kernel] 0x40
kernel: [<e000000004519400>] sp=0xe00000406b2f7e60 
bsp=0xe00000406b2f12a8 filp_close [kernel] 0x1a0
kernel: [<e000000004519660>] sp=0xe00000406b2f7e60 
bsp=0xe00000406b2f1258 sys_close [kernel] 0x1e0
kernel: [<e00000000440ea00>] sp=0xe00000406b2f7e60 
bsp=0xe00000406b2f1258 ia64_ret_from_syscall [kernel] 0x0
