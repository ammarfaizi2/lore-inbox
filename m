Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129890AbQKQIsv>; Fri, 17 Nov 2000 03:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130026AbQKQIsl>; Fri, 17 Nov 2000 03:48:41 -0500
Received: from tcbru42.cec.be ([158.169.131.23]:15575 "EHLO tcbru42.cec.be")
	by vger.kernel.org with ESMTP id <S129890AbQKQIse> convert rfc822-to-8bit;
	Fri, 17 Nov 2000 03:48:34 -0500
From: Sebastien.Rigaud@cec.eu.int
Message-ID: <5D802E6EDA71D411BFA900D0B76DEB1B4403DF@EX2BEL86MBX02>
To: linux-kernel@vger.kernel.org
Subject: "unable to handle paging request..."
Date: Fri, 17 Nov 2000 09:18:10 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I found that it's possible to submit you error messages and ask for help...
I've installed Red Hat 6.2 on an AMD300, without problem. Everything
works fine (Oracle server, Java developments...), but EVERY TIME I
shut my machine down, I always get the following message, just after
the line "stopping all md devices":

^ [<c0150c0f>] [<c0111212>] [<c01100dd>] [<..>]
^ ...
^ 
^ Code: <1>Unable to handle kernel paging request at virtual address
0000872f
^ Current->tss.cr3 = 069c0000, %cr3 = 069c0000
^ *pde = 00000000
^ Oops: 0000
^ CPU:    0
^ EIP:    0010:[<c010a481>]
^ EFLAGS: 00010046
^ eax: 00000000  ebx: ...  ecx: ..  edx: ..
^ esi: ..        edi: ...  ebp: ..  esp: ..
^ ds: 0018  es: 0018  ss: 0018
^ Process halt (pid: 1019, process nr: 18, stack page = c6507000)
^ Stacks fee1dead ....
^        ...
^ Call Trace: [<c..>] ..
^ Code: 8a 04 0b 89 44 ..

Most of the figures & hex addresses are the same each time the error occurs 
(in particular the "virtual address" 0000872f). Then if I do a
Ctrl-Alt-Delete I see 
the message "stopping all md devices" again and my PC eventually reboots... 
If I do not Ctrl-Alt-Del, it stays stalled.

This looks like something very low-level, and it's much too involved to me:
could
you please help me perhaps ?? Is it a hardware pb ? Or is the kernel
instable ?...

Thanks a lot !!
Best regards,
Sébastien



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
