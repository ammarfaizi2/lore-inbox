Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319362AbSHVPPv>; Thu, 22 Aug 2002 11:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319363AbSHVPPv>; Thu, 22 Aug 2002 11:15:51 -0400
Received: from pop.gmx.net ([213.165.64.20]:9307 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S319362AbSHVPPv>;
	Thu, 22 Aug 2002 11:15:51 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <m.c.p@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4 kernel series and the oom_killer and /proc/sys/vm/overcommit_memory
Date: Thu, 22 Aug 2002 17:19:50 +0200
X-Mailer: KMail [version 1.4]
Organization: WOLK - Working Overloaded Linux Kernel
X-PRIORITY: 2 (High)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200208221719.50568.m.c.p@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I just have one question.

If I understand it correct, /proc/sys/vm/overcommit_memory controls if there 
is "1" always enough memory and if "0" every program call checks if there is 
enough memory.

I just tried to open up much Xterms until my RAM + SWAP is full. The system is 
up and response is slowly for ~ 5 minutes, doing whatever, swapping or kinda 
that. This was tested with overcommit_memory == 0 ... With 2.4.19, the 
oom_killer comes NOT in action, after the 5 minutes the system is dead. With 
2.4.18's oom_killer there are program kills at random.

My question now: Why isn't it possible, if overcommit_memory is 0, to really 
check if there is enough memory or not, and if NOT just to display a message 
like "Not enough memory for execution. Aborted" ?

TIA!

-- 
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/569DE2E3DB441A16
Fingerprint: 3469 0CF8 CA7E 0042 7824 080A 569D E2E3 DB44 1A16
Key available at www.keyserver.net. Encrypted e-mail preferred.
