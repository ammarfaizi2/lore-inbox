Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129765AbRASSa7>; Fri, 19 Jan 2001 13:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130541AbRASSau>; Fri, 19 Jan 2001 13:30:50 -0500
Received: from mout0.freenet.de ([194.97.50.131]:45533 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S129765AbRASSaR>;
	Fri, 19 Jan 2001 13:30:17 -0500
From: mkloppstech@freenet.de
Message-Id: <200101191800.TAA00672@john.epistle>
Subject: oops
To: linux-kernel@vger.kernel.org
Date: Fri, 19 Jan 2001 19:00:31 +0100 (CET)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Many oopses appeared, among others gcc closed with signal 11.

One output:
Jan 19 18:45:12 john kernel: Unable to handle kernel paging request at virtual a
Jan 19 18:45:12 john kernel:  printing eip:
Jan 19 18:45:12 john kernel: c0123b27
Jan 19 18:45:12 john kernel: *pde = 00000000
Jan 19 18:45:12 john kernel: Oops: 0000
Jan 19 18:45:12 john kernel: CPU:    0
Jan 19 18:45:12 john kernel: EIP:    0010:[__find_lock_page+23/224]
Jan 19 18:45:12 john kernel: EFLAGS: 00010206
Jan 19 18:45:12 john kernel: eax: cff40000   ebx: 000d3199   ecx: c44f2d64   edx
Jan 19 18:45:12 john kernel: esi: fffffff4   edi: cff7f8e4   ebp: c44f2d64   esp
Jan 19 18:45:12 john kernel: ds: 0018   es: 0018   ss: 0018
Jan 19 18:45:12 john kernel: Process cpp (pid: 7077, stackpage=c45e1000)
Jan 19 18:45:12 john kernel: Stack: cff7f8e4 fffffff4 00000004 c45e1f98 c0126210
Jan 19 18:45:12 john kernel:        ffffffea cc730640 0000aba8 bfffee4c 00001000
Jan 19 18:45:12 john kernel:        cff7f8e4 00000001 00000000 00000004 c44f2d1c
Jan 19 18:45:12 john kernel: Call Trace: [generic_file_write+656/1232] [sys_writ
Jan 19 18:45:12 john kernel:

Please cc to mkloppstech@freenet.de
Mirko Kloppstech
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
