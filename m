Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129076AbQKIIRZ>; Thu, 9 Nov 2000 03:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129187AbQKIIRP>; Thu, 9 Nov 2000 03:17:15 -0500
Received: from lama.supermedia.pl ([212.75.96.18]:28179 "EHLO
	lama.supermedia.pl") by vger.kernel.org with ESMTP
	id <S129076AbQKIIRL>; Thu, 9 Nov 2000 03:17:11 -0500
Date: Thu, 9 Nov 2000 09:16:52 +0100
From: Bartek Krajnik <bartek@supermedia.pl>
To: linux-kernel@vger.kernel.org
Subject: X crash with kernel 2.4.0-test10 
Message-ID: <20001109091652.B18068@lama.supermedia.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On RedHat 6.2 with X 3.3.6-20:

Caught signal 11.

Server aborting...

eip: 0822e4e8   eflags: 00013293
eax: 00000004   ebx: 4018c608   ecx: 00000004   edx: 00000000
esi: 00000008   edi: 408a12f4   ebp: bffff860   esp: bffff7d4
Stack: 438a2008 bffff880 084b7ea8 00000002 408a12f4 00000004 0000000c bffff804
       40095fba 00000000 084f05d0 0101b278 00000000 00000004 084f05d0 00000000
       00000000 00000004 00000000 00000000 4018cc48 408a1908 00000001 00000001
       0000000e 4012c1ec 0000023a 0000022b 0000022b 00000004 084f0518 00000190
Call Trace: 08228fd5 08295889 08297a28 082900d8 0829d2b7 082900b0 0829d4b7
       081a9d3f 081ba6f7 081b9db7 081a25bb 08192847 081921e6 0813ebd0 081382c0
       08133450 0808541f 08292ecb 0829a593 0829b0b9 081a1532 0819a9a3 081920e8
       081a1155 08082590 080825b1 081a0d10 082f853c 08082590
Code: 8b 07 89 03 83 c3 04 83 c7 04 89 7d 84 8b 4d 84 8b 01 89 03

-- 
	System & Network
			Engineer
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
