Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131205AbRAVWpc>; Mon, 22 Jan 2001 17:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131355AbRAVWpW>; Mon, 22 Jan 2001 17:45:22 -0500
Received: from msgbas1tx.cos.agilent.com ([192.6.9.34]:9209 "HELO
	msgbas1t.cos.agilent.com") by vger.kernel.org with SMTP
	id <S131205AbRAVWpM>; Mon, 22 Jan 2001 17:45:12 -0500
Message-ID: <FEEBE78C8360D411ACFD00D0B7477971880958@xsj02.sjs.agilent.com>
From: "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: parallel mkfs on ia64 with 2.4.0
Date: Mon, 22 Jan 2001 17:45:07 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I ran mkfs on more than 1 scsi disk partitions
in parallel in background on ia64 Lion machine with linux kernel 
2.4.0. And after a few seconds, the system became damn slow. 
I can swith between the virtual terminals. But I cannot login
from other virtual terminals. Also, I cannot do anything
on the terminal on which I started the mkfs processes. 
If I run the mkfs sequentially, and then mount those
partitions, then I can run the I/Os to file systems
in parallel without any problem. Well, definitely, in this
case, the I/Os are going through the file system layer of
the kernel whereas in the former case, the I/Os to create
the file system are not going through the file system layer
of the kernel (except through the file system layer which
handles devices). Also, running mkfs in parallel works perfectly
without any problem on ia32 system with RedHat Linux 7.0 (kernel 2.2.16-22).
Is there any thing broken in 2.4.0 file system layer which makes system
damn slow ?

If you need any more information, please let me know.

Thanks and regards,
-hiren
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
