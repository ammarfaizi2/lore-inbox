Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132091AbRAJW2p>; Wed, 10 Jan 2001 17:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132676AbRAJW2f>; Wed, 10 Jan 2001 17:28:35 -0500
Received: from jalon.able.es ([212.97.163.2]:60107 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S132658AbRAJW20>;
	Wed, 10 Jan 2001 17:28:26 -0500
Date: Wed, 10 Jan 2001 23:28:13 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: PIII vs FXSR
Message-ID: <20010110232813.A984@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arch/i386/Makefile:

--- linux-2.4.0-ac5/arch/i386/Makefile.org      Wed Jan 10 23:22:54 2001
+++ linux-2.4.0-ac5/arch/i386/Makefile  Wed Jan 10 23:23:10 2001
@@ -50,7 +50,7 @@
 CFLAGS += -march=i686
 endif
 
-ifdef CONFIG_M686FXSR
+ifdef CONFIG_MPENTIUMIII
 CFLAGS += -march=i686
 endif

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.0-ac4 #1 SMP Mon Jan 8 22:10:06 CET 2001 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
