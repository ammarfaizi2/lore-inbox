Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129488AbQKMNKj>; Mon, 13 Nov 2000 08:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129706AbQKMNK3>; Mon, 13 Nov 2000 08:10:29 -0500
Received: from ha1.rdc2.nsw.optushome.com.au ([203.164.2.50]:21929 "EHLO
	mss.rdc2.nsw.optushome.com.au") by vger.kernel.org with ESMTP
	id <S129488AbQKMNKO>; Mon, 13 Nov 2000 08:10:14 -0500
Message-ID: <3A0FE8D5.A4C9FA0@optushome.com.au>
Date: Tue, 14 Nov 2000 00:12:53 +1100
From: Joel Beach <joelbeach@optushome.com.au>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Unresolved references for symbols bh_task_vec, tasklet_hi_vec
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi....I was just trying to compile and load a kernel module, and I got
the following two unresolved symbols...

1. tasklet_hi_vec
2. bh_task_vec

Now, after grepping through the source I found these structures in
softirq.c. ksyms.c seems to export these symbols (doesn't appear to be
within a conditional #if)...Why isn't my kernel module able to see my
symbols?

Kernel is 2.4.0-test10....The source tree does match the running kernel
;-)

Thanks,

Joel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
